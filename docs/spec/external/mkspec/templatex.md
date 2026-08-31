# 外部仕様書 — `Templatex` クラス

**完全修飾名**: `Mkspec::Templatex`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/templatex.md` の内部仕様書と `lib/mkspec/templatex.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

`TestScript`の構造（`TestGroup`/`TestCase`）から、RSpec `describe`/`context`を表すERubyテンプレート（`content.txt`相当）を組み立て、ファイルへ出力するクラス。責務外の事項として、テンプレートとデータYAMLの合成（`Item`/`Root`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「テンプレート生成器」を表す（`Template`に接尾辞`x`を付与）。
- 必須責務: `Setting`が保持する構造からERubyテンプレート文字列を組み立て、ファイルへ出力すること。
- 基底クラス: なし。
- 依存クラス: `Setting`（入力）、`Config`（パス解決）、`GlobalConfig`（定数参照）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Setting` | 参照 | `testscript`/`template_path`/`func_name_of_make_arg`の取得元 |
| `Config` | 参照 | `make_path_under_template_and_data_dir` |
| `GlobalConfig` | 参照 | `TEST_ARCHIVE_DIR`定数 |
| `Util` | 参照 | `get_file_content` |

## 4. 公開属性・定数

該当なし（外部から参照可能な属性・定数は定義されていない）。

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | テンプレート生成の準備を行う |
| `setup` | インスタンス | テンプレート文字列を組み立てる |
| `output` | インスタンス | テンプレート文字列をファイルへ出力する |

## 6. 公開メソッド仕様

### 6.1 `initialize(setting, config)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **引数**: `setting`（Setting）、`config`（Config）
- **戻り値**: 生成された`Templatex`インスタンス
- **処理**: `setting`からテンプレートパスと`func_name_of_make_arg`を取得し、出力先ディレクトリが無ければ作成する
- **状態変化・副作用**: 出力先ディレクトリが作成されうる

### 6.2 `setup()`

- **種別**: インスタンスメソッド
- **前提条件**: `GlobalConfig::TEST_ARCHIVE_DIR`配下に`rspec_head/content.txt`が存在すること
- **戻り値**: `true`（固定。内部エラーの有無に関わらず常に`true`を返す点に注意）
- **処理**:
  1. `rspec_head/content.txt`の内容を先頭行とする
  2. 各`TestGroup`・`TestCase`に対応するERubyタグ行を積み上げる
  3. 末尾に終端タグを追加し、全体を改行で連結して内部バッファに保持する

### 6.3 `output()`

- **種別**: インスタンスメソッド
- **前提条件**: `setup`が完了していること
- **戻り値**: Boolean（成功時`true`）
- **処理**: 組み立てたテンプレート文字列を`template_path`へ書き込む
- **状態変化・副作用**: テンプレートファイルが作成される
- **例外・エラー**: `MkspecDebugError` — 書き込みに失敗した場合

## 7. 入出力・永続化

- **入力ファイル**: `<TEST_ARCHIVE_DIR>/rspec_head/content.txt`
- **出力ファイル**: テンプレート本体ファイル（`template_path`、通常`content.txt`）

## 10. エラー処理・終了コード

`Templatex#setup`/`#output`は`Mkscript#make_template`（`create_files`→`create_all_template_and_data`経由、CLIの`begin...rescue`の**内側**）から呼び出される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `output`が`MkspecDebugError`を送出 | `create_all_template_and_data`に個別の`rescue`はないため、`bin/mkspec`の`rescue Mkspec::MkspecDebugError`まで直接伝播する。`STATE`は本経路では未変更のため | 100（`MKSPEC_DEBUG_ERROR`） |
| `setup`内で（`rspec_head/content.txt`不在等により）`Util.get_file_content`が例外を送出しない場合でも、`setup`は常に`true`を返すため呼び出し元は成功と誤認する | 実害が顕在化するのは後続の`output`で不完全な内容が書き込まれた場合のみ | コマンド自体はこの時点では異常終了しない |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/templatex.rb` の `Mkspec::Templatex` |
