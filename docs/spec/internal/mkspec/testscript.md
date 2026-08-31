# TestScript — クラス内部仕様書

**ファイル**: `lib/mkspec/testscript.rb`
**継承**: なし

## 概要

複数の `TestGroup` を束ね、含まれる `TestCase` の総数が上限（`limit`）を超えないように管理するクラス。spec出力ファイル名（`script_name`）も保持する。1つのRSpec `describe`ブロック（＝1つの出力ファイル）に相当する単位。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `name` | String | `attr_reader`。テストスクリプト名 |
| `script_name` | String | `attr_reader`。`Util.make_spec_filename(name)` により生成されるファイル名 |
| `test_groups` | Array<TestGroup> | `attr_reader`。含まれる`TestGroup` |
| `total_test_cases` | Integer | `attr_reader`。含まれる`TestCase`の総数 |
| `inner_result` | Symbol | `attr_reader`。`grouping`実行時の内部状態（デバッグ用の詳細区分） |
| `@limit` | Integer | `TestCase`総数の上限 |

---

## メソッド

### `initialize(name, limit) -> TestScript`

テストスクリプト名と上限を設定する。

**Args**: `name` — テストスクリプト名、`limit` — 含まれる`TestCase`総数の上限
**Raises**: `MkspecAppError` — `name` が空文字列の場合

### `grouping(testgroup) -> Symbol`

`testgroup` を追加可能かを判定し、可能なら `@test_groups` に追加する。上限を超える場合でも、既存グループが空（最初のグループ）であれば強制的に追加する救済ロジックを持つ。

処理フロー:
  1. 現在の合計が`limit`未満なら、追加後の合計が`limit`以下かを確認して追加する（`:NOT_EMPTY`）
  2. `limit`超過時は「limit内に収まる残量」と「limitを超える量」を比較し、内側の方が大きければ超過を許容して追加する
  3. それ以外（外側の方が大きい）場合は、`@test_groups`が空なら強制的に追加した上で`:EMPTY`を返す（呼び出し元に新しい`TestScript`を作らせるトリガーとなる）
  4. 現在の合計が既に`limit`以上の場合も、`@test_groups`が空なら強制追加する

**Args**: `testgroup` — 追加を試みる`TestGroup`
**Returns**: `:NOT_EMPTY`（追加成功）または `:EMPTY`（上限超過のため新しい`TestScript`が必要）

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Util.not_empty_string?` / `make_spec_filename` | `name`検証・ファイル名生成 |

---

## 設計上の注意

- `grouping` の `@total_test_cases >= @limit` 分岐（`else`側）内で `@total_test_cases = next_size` としているが、`next_size` はこの`else`分岐では定義されていないローカル変数である（`next_size`は`if @total_test_cases < @limit`側でのみ定義される）。`@test_groups.empty?`が真の状態でこの分岐に到達すると`NameError`になる可能性がある。
- `inner_result`は`:NOT_EMPTY_1`〜`:EMPTY_2`という内部状態の詳細区分を記録するが、テスト以外からこの値を参照している箇所は見当たらない。
