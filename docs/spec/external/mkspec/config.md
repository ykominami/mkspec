# 外部仕様書 — `Config` クラス

**完全修飾名**: `Mkspec::Config`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/config.md` の内部仕様書と `lib/mkspec/config.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

出力・テンプレート/データ・テストケースの各ディレクトリのパスを管理し、必要なディレクトリの作成と、アーカイブディレクトリ（`_test_case_archive`/`_test_archive`）の内容を出力先へコピーするセットアップ処理を提供するクラス。責務外の事項として、コピーしたテンプレート/データの内容解釈（`Item`/`Root`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「フレームワークの構成情報」を表す。
- 必須責務: 出力先ディレクトリ構造の作成と、アーカイブ内容の展開。
- 基底クラス: なし。
- 依存クラス: `GlobalConfig`（ディレクトリ名定数の参照元）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `GlobalConfig` | 参照 | `TEST_DIR`/`MISC_DIR`/`OUTPUT_TEMPLATE_AND_DATA_DIR`/`OUTPUT_TEST_CASE_DIR`/`TEST_CASE_ARCHIVE_DIR`/`TEST_ARCHIVE_DIR`の各定数 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `test_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `<data_top_dir>/test` | テストディレクトリ | 不可 |
| `misc_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `<test_dir_pn>/misc` | miscディレクトリ | 不可 |
| `output_script_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `setup`実行後に確定 | スクリプト出力先ディレクトリ | 不可 |
| `output_template_and_data_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `setup`実行後に確定 | テンプレート/データ出力先ディレクトリ | 不可 |
| `output_test_case_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `setup`実行後に確定 | テストケース出力先ディレクトリ | 不可 |
| `archive_dir_pn` | インスタンス属性（読み取り専用） | Pathname | `<test_dir_pn>/_test_archive` | アーカイブディレクトリ | 不可 |
| `spec_dir_pn` | インスタンス属性（読み取り専用） | 常に`nil` | - | 実装上未設定のまま公開される属性（§10参照） | 不可 |
| `output_dir_pn` | インスタンス属性（読み取り専用） | 常に`nil` | - | 実装上未設定のまま公開される属性（§10参照） | 不可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | ディレクトリパスを正規化して保持する |
| `setup` | インスタンス | 出力ディレクトリ構造を作成しアーカイブ内容をコピーする |
| `make_path_under_misc_dir` | インスタンス | miscディレクトリ配下のパスを組み立てる |
| `make_path_under_template_and_data_dir` | インスタンス | テンプレート/データディレクトリ配下のパスを組み立てる |
| `make_path_under_script_dir` | インスタンス | スクリプトディレクトリ配下のパスを組み立てる |
| `make_path_under_test_case_dir` | インスタンス | テストケースディレクトリ配下のパスを組み立てる |

## 6. 公開メソッド仕様

### 6.1 `initialize(data_top_dir, output_data_top_dir, tad_dir, test_case_dir = nil)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: なし
- **引数**: `data_top_dir`（String） — ソースデータのトップディレクトリ、`output_data_top_dir`（String） — 出力先トップディレクトリ、`tad_dir`（String） — テンプレート/データディレクトリ、`test_case_dir`（String, 省略可） — テストケースディレクトリ
- **戻り値**: 生成された`Config`インスタンス
- **処理**: `data_top_dir`/`output_data_top_dir`を`Pathname`化し、`tad_dir`/`test_case_dir`が指定されていれば絶対パスに展開する
- **状態変化・副作用**: なし
- **例外・エラー**: なし

### 6.2 `setup()`

- **種別**: インスタンスメソッド
- **前提条件**: なし（2回目以降の呼び出しは冪等）
- **引数**: なし
- **戻り値**: `self`
- **処理**:
  1. 既に`setup`実行済みなら即座に`self`を返す
  2. 出力トップディレクトリを作成する
  3. `tad_dir`/`test_case_dir`の絶対パスを解決する
  4. `script`/`template_and_data`/`test_case`の各出力ディレクトリを準備する
  5. `_test_case_archive`を出力`test_case`ディレクトリへコピーする
  6. `_test_archive`を出力`template_and_data`ディレクトリへコピーする
- **状態変化・副作用**: 出力先ディレクトリ・ファイルが作成される（ファイルシステムへの副作用）
- **例外・エラー**: `MkspecDebugError` — `_test_case_archive`ディレクトリが存在しない場合

### 6.3 `make_path_under_misc_dir(fname)` / `make_path_under_template_and_data_dir(fname)` / `make_path_under_script_dir(fname)` / `make_path_under_test_case_dir(fname)`

- **種別**: インスタンスメソッド
- **引数**: `fname`（String/Pathname）
- **戻り値**: `Pathname`（対応する出力ディレクトリ配下に`fname`を結合したパス）
- **例外・エラー**: なし

## 7. 入出力・永続化

- **入力ディレクトリ**: `<data_top_dir>/test/_test_case_archive`、`<data_top_dir>/test/_test_archive`
- **出力ディレクトリ**: `<output_data_top_dir>` 配下の `script`/`template_and_data`/`test_case`（`setup`実行時に作成・コピー）

## 9. 不変条件・状態遷移

- `setup`は一度成功すると以後の呼び出しに対して冪等（内部カウンタによるガード）。ただし1回目の呼び出しが`_test_archive`不在で早期リターンした場合、内部カウンタは加算されないため、再度`setup`を呼ぶと同じ処理をやり直す。

## 10. エラー処理・終了コード

`Config#setup`は`Mkscript#init_sub`（`Mkscript#init`経由、CLIの`begin...rescue`の**外側**）から呼び出される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `_test_case_archive`ディレクトリが存在しない | `MkspecDebugError`送出。`bin/mkspec`の`begin`外側のため未捕捉、Rubyの未捕捉例外としてプロセス終了 | 1（Ruby既定。フレームワーク定義の`100`にはならない） |
| `_test_archive`ディレクトリが存在しない | 例外は送出されず、`setup`が処理を打ち切って`self`を返す（アーカイブが未展開のまま後続処理が進む） | コマンド自体は異常終了しない（ただし後続でテンプレートファイルが見つからず別のエラーに繋がりうる） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/config.rb` の `Mkspec::Config` |
