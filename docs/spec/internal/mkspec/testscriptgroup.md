# TestScriptGroup — クラス内部仕様書

**ファイル**: `lib/mkspec/testscriptgroup.rb`
**継承**: なし

## 概要

TSVファイルを読み込み `TestGroup`/`TestCase` を生成し、上限（`limit`）を超えないよう `TestScript` 単位に分割してまとめるクラス。TSVの各行は「グループ名 / テストケース番号 / 任意の追加パラメータ」の形式を想定する（AGENTS.md「テストデータ形式」参照）。

---

## クラス定数

| 定数名 | 値 | 説明 |
|--------|----|------|
| `DEFAULT_VALUES` | `['to', 'be_successfully_executed', 'execute successfully', 'test_normal_sh:true', 'not_to', 'have_output(/error:/)', "don't have error in output", 'test_normal_sh_out:true'].freeze` | TSVで値が省略された場合に使う、`test_1`/`test_1_value`/`test_1_message`/`test_1_tag`/`test_2`/`test_2_value`/`test_2_message`/`test_2_tag`の8項目のデフォルト値（この順序で対応する） |

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `testscripts` | Array<TestScript> | `attr_reader`。構築された`TestScript`群 |
| `name` | String | `attr_reader`。テストスクリプト命名に使う開始文字（`start_char`） |
| `@tsv_path` | String | TSVファイルのパス |
| `@limit` | Integer | `TestScript`あたりの`TestCase`数上限 |
| `@make_arg_basename` | String | make引数生成用のベース名 |
| `@current_testscript` | TestScript | 現在構築中の`TestScript` |
| `@data` | Hash | `setup_from_tsv`の結果（グループ名 => `TestGroup`） |

---

## メソッド

### `initialize(tsv_path, start_char, limit, make_arg_basename) -> TestScriptGroup`

TSVファイルのパス・命名用開始文字・上限・make引数ベース名を保持し、最初の`TestScript`を作成する。

**Args**: `tsv_path` — TSVファイルのパス、`start_char` — テストスクリプト命名の開始文字、`limit` — `TestScript`あたりの上限、`make_arg_basename` — make引数のベース名
**Raises**: `MkspecAppError` — `start_char` が空文字列の場合

### `setup_test_group(line, state) -> TestScriptGroup`

TSV1行をタブ区切りで分解し、コメント行・空欄・不正な数値列を除外した上で、`state`（グループ名 => `TestGroup`）にテストケースを追加する。

処理フロー:
  1. `tgroup`, `tcase`, `*tmp` に分解する（タブ区切り）
  2. `tgroup`/`tcase`が`nil`またはコメント（`#`始まり）なら何もせず終了する
  3. `tmp`の要素数が4を超える場合、または1〜7番目の要素が数値チェックに引っかかる場合は終了する
  4. `tgroup`/`tcase`の`-`と`.`を`_`に置換する
  5. `state[tgroup]`が無ければ`TestGroup`を新規作成する
  6. `DEFAULT_VALUES`と`tmp[0, 8]`をzipし、指定があれば上書きした8項目の配列を作る
  7. `TestGroup#add_test_case`でテストケースを追加する

**Args**: `line` — TSVの1行、`state` — グループ名をキーとするハッシュ
**Returns**: `self`

### `setup_from_tsv -> Hash`

TSVファイルを1行ずつ読み込み、コメント・空行を除いて`setup_test_group`を適用し、グループ名 => `TestGroup`のハッシュを構築する。

### `setup -> TestScriptGroup`

`setup_from_tsv`で得た各`TestGroup`を`@current_testscript`に`grouping`し、上限超過時は新しい`TestScript`（`next_name`）を作成して続行する。

**Returns**: `self`

### `make_testscript(name) -> TestScript`

`TestScript.new`を生成し`@testscripts`に追加する。

**Args**: `name` — 新しい`TestScript`の名前

### `next_name -> String`

`@name`を`succ`（次の文字列）にして返す。

### `result -> Array<TestScript>`

`@testscripts`を返す。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `TestGroup` / `TestCase` / `TestScript` | 構造の生成 |
| `Util.not_empty_string?` / `check_numeric` | 入力検証 |
| `Loggerxcm` | ログ出力 |

---

## 設計上の注意

- `setup_test_group`内に `retirm self`（本来`return self`）という誤字があり、`tgroup`が`nil`の場合にこの行に到達すると`NoMethodError`になる。
- `DEFAULT_VALUES`の要素順（`test_1`, `test_1_value`, `test_1_message`, `test_1_tag`, `test_2`, `test_2_value`, `test_2_message`, `test_2_tag`）はコード中にコメントで明示されておらず、`zip`と`array`への分割代入からのみ読み取れる。
