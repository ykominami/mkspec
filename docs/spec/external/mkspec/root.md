# 外部仕様書 — `Root` クラス

**完全修飾名**: `Mkspec::Root`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/root.md` の内部仕様書と `lib/mkspec/root.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

トップレベルのデータYAMLを読み込み、`Item`の階層を再帰的に構築してRSpec仕様ファイルの文字列を生成する、`Mkscript#make_spec_file`からのエントリーポイントクラス。責務外の事項として、生成した文字列のファイル出力・整形（`Mkscript`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「spec生成の起点（ルート）」を表す。
- 必須責務: トップレベルのデータYAMLからルート`Item`を構築し、最終的なspec文字列を返すこと。
- 基底クラス: なし。
- 依存クラス: `Item`（コンテンツ生成の再帰単位）、`Config`（パス解決）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Item` | 合成 | ルート`Item`および子`Item`の生成 |
| `Config` | 参照 | `make_path_under_misc_dir`/`make_path_under_template_and_data_dir` |
| `Util` | 参照 | YAML抽出・ハッシュ検証・ERuby展開 |

## 4. 公開属性・定数

該当なし（外部から参照可能な属性・定数は定義されていない）。

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | データYAMLを読み込みトップレベルのテンプレートパスを解決する |
| `result` | インスタンス | ルート`Item`からspec文字列を生成して返す |

## 6. 公開メソッド仕様

### 6.1 `initialize(yml_fname, config)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `yml_fname`または`config.make_path_under_misc_dir`で解決したパスのいずれかが実在すること
- **引数**: `yml_fname`（String） — データYAMLファイルのパス、`config`（Config）
- **戻り値**: 生成された`Root`インスタンス
- **処理**:
  1. `yml_fname`の実在確認、無ければmiscディレクトリ基準で解決する
  2. YAMLから設定ハッシュを抽出し`"top_dir"`キーの型を検証する
  3. `path`キーからトップレベルのテンプレートパスを解決する
- **例外・エラー**: `MkspecDebugError` — YAMLファイルが見つからない場合、検証失敗時、`path`が取得できない場合

### 6.2 `result()`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **引数**: なし
- **戻り値**: `String`（生成されたspec文字列）または`nil`（コンテンツが空の場合）
- **処理**:
  1. トップレベルのハッシュから子`Item`を構築しつつルート`Item`を生成する
  2. ルート`Item#result`でコンテンツ文字列を取得する
  3. 空でなければ`Util.extract_with_eruby`で再度ERuby展開して返す
- **例外・エラー**: `Item`の構築・展開過程で送出される`MkspecDebugError`/`MkspecAppError`がそのまま伝播する

## 7. 入出力・永続化

- **入力ファイル**: トップレベルのデータYAMLファイル（`yml_fname`）

## 9. 不変条件・状態遷移

- `result`は`make_item`を経由して`Item`階層全体を1回のみ構築する（インスタンスの再利用や再展開は想定していない）。

## 10. エラー処理・終了コード

`Root.new(...).result`は`Mkscript#make_spec_file`内の`begin...rescue StandardError`（`create_files`経由、CLIの`begin`の**内側**）で保護されている。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `initialize`/`extract_in_hash_with_setting_hash`が`MkspecDebugError`を送出、または子`Item`が例外を送出 | `Mkscript#make_spec_file`内の`rescue StandardError`で捕捉され`STATE`が`CANNOT_MAKE_SPEC_FILE`に変更された後、`MkspecAppError`として再送出され`bin/mkspec`の`rescue Mkspec::MkspecAppError`で捕捉される | 24（`CANNOT_MAKE_SPEC_FILE`） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/root.rb` の `Mkspec::Root` |
