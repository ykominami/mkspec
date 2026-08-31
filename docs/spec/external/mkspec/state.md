# 外部仕様書 — `State` クラス

**完全修飾名**: `Mkspec::State`
**種別**: 通常クラス（グローバル状態保持）

本書は `docs/spec/internal/mkspec/state.md` の内部仕様書と `lib/mkspec/state.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

Mkspecフレームワーク全体の処理結果（終了コード・メッセージ）を保持する状態オブジェクト。`lib/mkspec/state.rb`末尾で `STATE = State.new` としてモジュール `Mkspec` 直下にグローバル定数（唯一のインスタンス）が定義されており、フレームワーク内の各処理はこのインスタンスに対して継続可否を判断し、エラー時に状態を更新する。利用者はフレームワーク内のほぼ全クラスであり、責務は「現在の終了コードとメッセージを保持・提供すること」のみで、実際のエラー原因の判定や復旧処理は責務外。

## 2. フレームワーク上の位置付け

- クラス名は「処理状態」を表す。
- 必須責務: 終了コード（`exit_code`）とメッセージ配列（`message_array`）を保持し、成功/終了判定メソッドを提供すること。
- 基底クラス: なし。
- 依存クラス: `Loggerxcm`（メッセージ表示）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Loggerxcm` | 参照 | `show_message`でのメッセージ表示 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `message_array` | インスタンス属性 | Array<String> | 初期値`[]` | 状態変更に関連するメッセージ群 | 可（`change`経由） |
| `exit_code` | インスタンス属性 | Integer | 初期値`SUCCESS`(0) | 処理の終了コード | 可（`change`経由） |
| `STATE`（モジュール定数、`Mkspec`直下） | モジュール定数 | State | `State.new` | フレームワーク全体で共有される唯一の`State`インスタンス | 不可（定数） |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | `exit_code`を`SUCCESS`に、`message_array`を空配列に初期化する |
| `success?` | インスタンス | `exit_code`が`SUCCESS`かどうかを返す |
| `finish?` | インスタンス | `exit_code`が`FINISH`かどうかを返す |
| `change` | インスタンス | `exit_code`と`message_array`を更新する |
| `show_message` | インスタンス | `message_array`を表示し、現在の`exit_code`を返す |

## 6. 公開メソッド仕様

### 6.1 `initialize()`

- **種別**: インスタンスメソッド（コンストラクタ）
- **戻り値**: 生成された`State`インスタンス
- **処理**: `exit_code = SUCCESS`、`message_array = []`に初期化する

### 6.2 `success?()`

- **種別**: インスタンスメソッド
- **戻り値**: Boolean（`exit_code == SUCCESS`）

### 6.3 `finish?()`

- **種別**: インスタンスメソッド
- **戻り値**: Boolean（`exit_code == FINISH`）

### 6.4 `change(exit_code, *message)`

- **種別**: インスタンスメソッド
- **引数**: `exit_code`（Integer） — 新しい終了コード、`message`（可変長） — メッセージ
- **戻り値**: `self`（メソッドチェーン用）
- **状態変化・副作用**: `exit_code`・`message_array`が更新される

### 6.5 `show_message(_message = nil)`

- **種別**: インスタンスメソッド
- **引数**: `_message`（省略可、未使用）
- **戻り値**: `exit_code`（Integer）
- **処理**: `message_array`を`Loggerxcm.show`に渡して表示する

## 9. 不変条件・状態遷移

- `STATE`はプロセス内で単一のインスタンスとして共有され、`change`が呼ばれるまで`success?`は真であり続ける。
- 状態遷移は一方向の上書きのみで、過去の状態履歴は保持しない（`change`のたびに`message_array`は置き換えられる）。

## 10. エラー処理・終了コード

本クラス自体は例外を送出しない。フレームワーク全体で`STATE.change`に渡される終了コードの一覧は `Mkspec` モジュールの外部仕様書（[mkspec.md](../mkspec.md)）§4を参照。コマンド自体が本クラスの処理により異常終了することはない。

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体・グローバル定数 | `lib/mkspec/state.rb` の `Mkspec::State`／`Mkspec::STATE` |
