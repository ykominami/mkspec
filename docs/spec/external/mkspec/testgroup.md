# 外部仕様書 — `TestGroup` クラス

**完全修飾名**: `Mkspec::TestGroup`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/testgroup.md` の内部仕様書と `lib/mkspec/testgroup.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

同一グループに属する複数の `TestCase` をまとめ、make引数生成用のコンテンツ名（`<make_arg_basename>_<name>`）を保持するクラス。責務外の事項として、TSV行の解析（`TestScriptGroup`の責務）やRSpec `context` 構造への変換（`Setting`の責務）は本クラスの範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「テストケースのグループ」を表す。
- 必須責務: `TestCase` の集合を保持し、件数上限判定（`TestScript#grouping`）に使う `size` を提供すること。
- 基底クラス: なし。
- 依存クラス: `TestCase`（生成）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `TestCase` | 合成 | `add_test_case`によるテストケース生成・保持 |
| `Util` | 参照 | `name`の非空文字列検証 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `name` | インスタンス属性（読み取り専用） | String | 非空文字列 | グループ名 | 不可 |
| `test_cases` | インスタンス属性（読み取り専用） | Array<TestCase> | 初期値`[]` | グループに追加されたテストケース | 不可（`add_test_case`経由でのみ追加） |
| `size` | インスタンス属性（読み取り専用） | Integer | 初期値0 | テストケース数 | 不可（`add_test_case`経由でのみ増加） |
| `content_name_of_make_arg` | インスタンス属性（読み取り専用） | String | `"<make_arg_basename>_<name>"` | make引数生成用のコンテンツ名 | 不可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | グループ名とmake引数生成用のコンテンツ名を設定する |
| `to_s` | インスタンス | グループ名を返す |
| `add_test_case` | インスタンス | `TestCase`を生成しグループに追加する |

## 6. 公開メソッド仕様

### 6.1 `initialize(name, make_arg_basename, extra = nil)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `name` が非空文字列であること
- **引数**: `name`（String） — グループ名、`make_arg_basename`（String） — make引数のベース名、`extra`（Object, 省略可） — 追加情報
- **戻り値**: 生成された `TestGroup` インスタンス
- **処理**: `@content_name_of_make_arg` を `[make_arg_basename, name].join('_')` として算出する
- **状態変化・副作用**: なし
- **例外・エラー**: `MkspecAppError` — `name` が空文字列または `String` でない場合

### 6.2 `to_s()`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **引数**: なし
- **戻り値**: `name`（String）
- **処理**: `@name` をそのまま返す
- **状態変化・副作用**: なし
- **例外・エラー**: なし

### 6.3 `add_test_case(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra = nil)`

- **種別**: インスタンスメソッド
- **前提条件**: なし（引数の検証は`TestCase.new`側で行われる）
- **引数**: `TestCase`のコンストラクタと同一（詳細は[testcase.md](testcase.md)参照）
- **戻り値**: 追加した `TestCase` インスタンス
- **処理**: `TestCase.new`でインスタンスを生成し、`test_cases`に追加、`size`を1増やす
- **状態変化・副作用**: `test_cases`・`size`が更新される
- **例外・エラー**: `MkspecAppError` — `TestCase.new`が送出する場合（`testcase_name`が空文字列等）

## 9. 不変条件・状態遷移

- `size == test_cases.size` が常に成立する（`add_test_case`が両者を同時に更新するため）。

## 10. エラー処理・終了コード

`TestGroup.new`・`add_test_case`は`TestScriptGroup#setup_test_group`から呼び出され、`Mkscript#init`（CLIの`begin...rescue`の**外側**）の経路で実行される。`MkspecAppError`が送出された場合、`bin/mkspec`では捕捉されずRubyの未捕捉例外としてプロセスが終了する。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `name`（グループ名）が空文字列 | `MkspecAppError`送出、`bin/mkspec`では未捕捉 | 1（Ruby既定） |
| `add_test_case`経由で`TestCase`の検証が失敗 | 同上 | 1（Ruby既定） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/testgroup.rb` の `Mkspec::TestGroup` |
