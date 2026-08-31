# 外部仕様書 — `TestScript` クラス

**完全修飾名**: `Mkspec::TestScript`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/testscript.md` の内部仕様書と `lib/mkspec/testscript.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

複数の `TestGroup` を束ね、含まれる `TestCase` の総数が上限（`limit`）を超えないように管理するクラス。1つのRSpec `describe` ブロック（＝1つの出力ファイル）に相当する単位であり、spec出力ファイル名（`script_name`）を保持する。責務外の事項として、TSV全体の分割方針の決定（`TestScriptGroup`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「1つの出力スクリプト単位」を表す。
- 必須責務: `grouping`により`TestGroup`を上限内で受け入れ、受け入れ可否を`:NOT_EMPTY`/`:EMPTY`で返すこと。
- 基底クラス: なし。
- 依存クラス: `TestGroup`（保持対象）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `TestGroup` | 合成 | `grouping`により保持する`TestGroup`群 |
| `Util` | 参照 | `name`の非空文字列検証、`script_name`のファイル名生成 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `name` | インスタンス属性（読み取り専用） | String | 非空文字列 | テストスクリプト名 | 不可 |
| `script_name` | インスタンス属性（読み取り専用） | String | `"<name>_spec.rb"` | spec出力ファイル名 | 不可 |
| `test_groups` | インスタンス属性（読み取り専用） | Array<TestGroup> | 初期値`[]` | 含まれる`TestGroup` | 不可（`grouping`経由でのみ追加） |
| `total_test_cases` | インスタンス属性（読み取り専用） | Integer | 初期値0 | 含まれる`TestCase`の総数 | 不可（`grouping`経由でのみ増加） |
| `inner_result` | インスタンス属性（読み取り専用） | Symbol | `:NOT_EMPTY_1`〜`:EMPTY_2` | `grouping`実行時の内部状態（デバッグ用の詳細区分） | 不可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | テストスクリプト名と上限を設定する |
| `grouping` | インスタンス | `TestGroup`を上限内で追加を試みる |

## 6. 公開メソッド仕様

### 6.1 `initialize(name, limit)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `name` が非空文字列であること
- **引数**: `name`（String） — テストスクリプト名、`limit`（Integer） — `TestCase`総数の上限
- **戻り値**: 生成された `TestScript` インスタンス
- **処理**: `script_name`を`Util.make_spec_filename(name)`で算出する
- **状態変化・副作用**: なし
- **例外・エラー**: `MkspecAppError` — `name` が空文字列または `String` でない場合

### 6.2 `grouping(testgroup)`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **引数**: `testgroup`（`TestGroup`） — 追加を試みるグループ
- **戻り値**: `:NOT_EMPTY`（追加成功）または`:EMPTY`（上限超過のため新しい`TestScript`が必要）
- **処理**:
  1. 現在の合計が`limit`未満なら、追加後の合計が`limit`以下かを確認して追加する
  2. `limit`超過時は「limit内に収まる残量」と「limitを超える量」を比較し、内側の方が大きければ超過を許容して追加する
  3. それ以外の場合は、`test_groups`が空なら強制的に追加した上で`:EMPTY`を返す（呼び出し元に新しい`TestScript`の作成を促す）
  4. 現在の合計が既に`limit`以上の場合も、`test_groups`が空なら強制追加する
- **状態変化・副作用**: `test_groups`・`total_test_cases`・`inner_result`が更新されうる
- **例外・エラー**: 実装上の欠陥により、現在の合計が`limit`以上かつ`test_groups`が空の場合に到達する分岐で`NameError`が発生しうる（詳細は内部仕様書[testscript.md](../../internal/mkspec/testscript.md)参照）

## 9. 不変条件・状態遷移

- `total_test_cases`は`grouping`が呼ばれるたびに単調増加する（減少しない）。
- `test_groups`が空の間は、上限超過であっても最低1つの`TestGroup`を強制的に保持する（空の`TestScript`を作らないための救済ロジック）。

## 10. エラー処理・終了コード

`TestScript.new`・`grouping`は`TestScriptGroup#setup`/`#make_testscript`から呼び出され、`Mkscript#init`（CLIの`begin...rescue`の**外側**）の経路で実行される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `name`が空文字列で`MkspecAppError`送出 | `bin/mkspec`では未捕捉、Rubyの未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `grouping`内の`next_size`未定義による`NameError`（設計上の注意参照） | 同上 | 1（Ruby既定） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/testscript.rb` の `Mkspec::TestScript` |
