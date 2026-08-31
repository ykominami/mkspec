# TestCase — クラス内部仕様書

**ファイル**: `lib/mkspec/testcase.rb`
**継承**: なし

## 概要

1件のテストケースの識別子・ディレクトリ・2組のテスト条件（`test_1`/`test_2`とその値・メッセージ・タグ）・追加情報（`extra`）を保持するデータクラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `name` | String | テストケース名 |
| `dir` | String | テストケースが配置されるディレクトリ |
| `test_1` | Symbol/String | 1つ目のテスト条件識別子 |
| `test_1_value` | Object | 1つ目のテスト条件の期待値 |
| `test_1_message` | String | 1つ目のテスト条件のメッセージ |
| `test_1_tag` | Symbol/String | 1つ目のテスト条件のタグ |
| `test_2` | Symbol/String | 2つ目のテスト条件識別子 |
| `test_2_value` | Object | 2つ目のテスト条件の期待値 |
| `test_2_message` | String | 2つ目のテスト条件のメッセージ |
| `test_2_tag` | Symbol/String | 2つ目のテスト条件のタグ |
| `extra` | Object, nil | 追加情報（省略可） |

---

## メソッド

### `initialize(name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra = nil) -> TestCase`

各属性をそのままインスタンス変数に設定する。

**Args**: 各テスト条件・メッセージ・タグ、`extra` — 追加情報（省略可）
**Raises**: `MkspecAppError` — `name` が空文字列の場合

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Util.not_empty_string?` | `name` の検証 |
