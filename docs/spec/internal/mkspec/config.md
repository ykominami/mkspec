# Config — クラス内部仕様書

**ファイル**: `lib/mkspec/config.rb`
**継承**: なし

## 概要

出力・テンプレート/データ・テストケースの各ディレクトリのパスを管理し、必要なディレクトリの作成と、アーカイブディレクトリ（`_test_case_archive` / `_test_archive`）の内容を出力先へコピーするセットアップ処理を提供する。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `spec_dir_pn` | Pathname | （`attr_reader`で公開されるが本ファイル内では代入されていない） |
| `test_dir_pn` | Pathname | `<data_top_dir>/test` |
| `misc_dir_pn` | Pathname | `<test_dir_pn>/misc` |
| `output_dir_pn` | Pathname | （`attr_reader`で公開されるが本ファイル内では代入されていない） |
| `output_script_dir_pn` | Pathname | スクリプト出力先ディレクトリ |
| `output_template_and_data_dir_pn` | Pathname | テンプレート/データ出力先ディレクトリ |
| `output_test_case_dir_pn` | Pathname | テストケース出力先ディレクトリ |
| `archive_dir_pn` | Pathname | `<test_dir_pn>/_test_archive` |
| `@setup_count` | Integer | `setup` の重複実行を防ぐためのガードカウンタ |

---

## メソッド

### `initialize(data_top_dir, output_data_top_dir, tad_dir, test_case_dir = nil) -> Config`

ディレクトリパスを正規化して保持する。

処理フロー:
  1. `data_top_dir` / `output_data_top_dir` を `Pathname` 化し、`test` / `misc` ディレクトリのパスを算出する
  2. `tad_dir` が指定されていれば絶対パスに展開して `@tad_dir` に保持する
  3. `test_case_dir` が指定されていれば絶対パスに展開して `@test_case_dir` に保持する

**Args**: `data_top_dir` — ソースデータのトップディレクトリ、`output_data_top_dir` — 出力先トップディレクトリ、`tad_dir` — テンプレート/データディレクトリ、`test_case_dir` — テストケースディレクトリ（省略可）

### `setup -> Config`

出力ディレクトリ構造を作成し、アーカイブ内容を出力先にコピーする。2回目以降の呼び出しは何もしない。

処理フロー:
  1. `@setup_count` が正なら即座に自身を返す（冪等化）
  2. 出力トップディレクトリを作成する
  3. `tad_dir` / `test_case_dir` の絶対パスを解決する
  4. `script` / `template_and_data` / `test_case` の各出力ディレクトリを準備する
  5. `_test_case_archive` を出力`test_case`ディレクトリへコピーする（存在しなければ`MkspecDebugError`を送出）
  6. `_test_archive` を出力`template_and_data`ディレクトリへコピーする（存在しなければ処理を中断して`self`を返す）

**Returns**: `self`
**Raises**: `Mkspec::MkspecDebugError` — `_test_case_archive` ディレクトリが存在しない場合

### `setup_dir(absolute_pn, dir, default_dir) -> Pathname`

`absolute_pn` が既にあればそれを、なければ `dir` または `default_dir` から出力ディレクトリを作成する。

**Args**: `absolute_pn` — 既知の絶対パス、`dir` — 指定ディレクトリ、`default_dir` — デフォルトディレクトリ

### `check_absolute_dir(dir) -> Pathname, nil`

指定ディレクトリの絶対パスを取得する。存在しない場合は `nil`。

### `check_dir(hash) -> nil`

`hash[:given]` の絶対パスを解決して `hash[:absolute]` に設定する（破壊的）。

### `setup_dir_content(src_dir, dest_dir) -> nil`

`src_dir` の内容を `dest_dir` へ再帰コピーする。両ディレクトリの実パスが取得できた場合のみコピーを実行する。

### `setup_directory(dir) -> Pathname`

出力トップディレクトリ配下に `dir` を作成する。

### `make_path_under_misc_dir(fname)` / `make_path_under_template_and_data_dir(fname)` / `make_path_under_script_dir(fname)` / `make_path_under_test_case_dir(fname) -> Pathname`

各出力ディレクトリ配下のパスを組み立てるヘルパー。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `GlobalConfig::TEST_DIR` / `MISC_DIR` / `OUTPUT_TEMPLATE_AND_DATA_DIR` / `OUTPUT_TEST_CASE_DIR` / `TEST_CASE_ARCHIVE_DIR` / `TEST_ARCHIVE_DIR` | ディレクトリ名の定数 |
| `Loggerxcm` | デバッグ・エラーログ出力 |
| `Mkspec::MkspecDebugError` | セットアップ失敗時の例外 |

---

## 設計上の注意

- `setup` 内で `setup_dir(@script_absolute_dir_pn, @output_script_dir, @output_script_dir)` としているが、`@output_script_dir` はこのクラス内のどこにも代入されておらず常に `nil` である（`@script_dir = "script"` という別変数が定義されているが未使用）。結果として `output_script_dir_pn` は常に `default_dir` 経路（`setup_directory(nil)`）で解決されることになる。
- `_test_case_archive` が存在しない場合は `MkspecDebugError` を送出するのに対し、`_test_archive` が存在しない場合はエラーを送出せず単に `self` を返して処理を打ち切るという非対称な挙動になっている。
- `attr_reader` に含まれる `spec_dir_pn` と `output_dir_pn` はこのファイル内で一度も代入されておらず、常に `nil` を返す。
