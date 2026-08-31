# TestGroup — クラス内部仕様書

**ファイル**: `lib/mkspec/testgroup.rb`
**継承**: なし

## 概要

同一グループに属する複数の `TestCase` をまとめるクラス。make引数生成用のコンテンツ名（`<make_arg_basename>_<name>`）を保持する。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `name` | String | `attr_reader`。グループ名 |
| `test_cases` | Array<TestCase> | `attr_reader`。グループに追加されたテストケース |
| `size` | Integer | `attr_reader`。テストケース数 |
| `content_name_of_make_arg` | String | `attr_reader`。`[make_arg_basename, name].join('_')` |
| `@extra` | Object, nil | 追加情報 |

---

## メソッド

### `initialize(name, make_arg_basename, extra = nil) -> TestGroup`

グループ名とmake引数生成用のコンテンツ名を設定する。

**Args**: `name` — グループ名、`make_arg_basename` — make引数のベース名、`extra` — 追加情報（省略可）
**Raises**: `MkspecAppError` — `name` が空文字列の場合

### `to_s -> String`

`@name` を返す。

### `add_test_case(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra = nil) -> TestCase`

`TestCase` を生成し `@test_cases` に追加、`@size` をインクリメントする。

**Returns**: 追加した `TestCase` インスタンス

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `TestCase` | テストケースの生成 |
| `Util.not_empty_string?` | `name` の検証 |
