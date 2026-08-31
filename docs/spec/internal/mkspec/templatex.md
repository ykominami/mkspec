# Templatex — クラス内部仕様書

**ファイル**: `lib/mkspec/templatex.rb`
**継承**: なし

## 概要

`TestScript` の構造（`TestGroup`/`TestCase`）から、RSpec `describe`/`context` を表すERubyテンプレート（`content.txt`相当）を組み立て、ファイルへ出力するクラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `@setting` | Setting | テンプレート生成対象の`Setting` |
| `@config` | Config | `Config` インスタンス |
| `@template_path` | Pathname | 出力先テンプレートファイルのパス |
| `@content` | String | 組み立てたテンプレート文字列 |
| `@func_name_of_make_arg` | String | make引数生成に使う関数名 |

---

## メソッド

### `initialize(setting, config) -> Templatex`

`setting` からテンプレートパスと`func_name_of_make_arg`を取得し、出力先ディレクトリが無ければ作成する。

**Args**: `setting` — 設定情報を持つ`Setting`、`config` — `Config`

### `make_line_1(name) -> String`

インデント2スペースで `<%= name %>` の行を生成する。

**Args**: `name` — テンプレートに埋め込む変数名

### `make_line_2(name) -> String`

インデント4スペースで `<%= name %>` の行を生成する。

**Args**: `name` — テンプレートに埋め込む変数名

### `setup -> Boolean`

`rspec_head/content.txt`の内容を先頭に、各`TestGroup`・`TestCase`に対応するERubyタグ行を積み上げ、テンプレート文字列を`@content`に構築する。

処理フロー:
  1. `TEST_ARCHIVE_DIR` 配下の `rspec_head/content.txt` を読み込み先頭行とする
  2. 各`test_group`について `make_line_1(グループ名)`、`make_line_2(make_arg名)` を追加する
  3. 各`test_case`について`extra`があれば`make_line_2(extra)`、続けて`make_line_2(ケース名)`を追加する
  4. グループ末尾に`rspec_describe_context_end`タグを追加する
  5. 末尾に`rspec_describe_end`タグを追加し、全体を改行で連結する

**Returns**: `true`（固定）

### `output -> Boolean`

`@content` を `@template_path` へ書き込む。

**Raises**: `Mkspec::MkspecDebugError` — 書き込みに失敗した場合

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `GlobalConfig::TEST_ARCHIVE_DIR` | テンプレート雛形の格納先 |
| `Util.get_file_content` | ファイル読み込み |
| `Loggerxcm` | ログ出力 |
| `Setting` | テンプレート生成対象 |

---

## 設計上の注意

- `setup` は常に `true` を返すため、内部でエラーが起きても呼び出し元（`Mkscript#make_template`）は成功したとみなしてしまう。
