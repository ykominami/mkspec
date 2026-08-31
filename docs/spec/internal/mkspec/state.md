# State — クラス内部仕様書

**ファイル**: `lib/mkspec/state.rb`
**継承**: なし

## 概要

Mkspecフレームワーク全体の処理結果（終了コード・メッセージ）を保持する状態オブジェクト。本ファイル末尾で `STATE = State.new` としてモジュール `Mkspec` 直下にグローバル定数（シングルトン的な唯一のインスタンス）が定義されており、各処理はこのインスタンスに対して `STATE.success?` で継続可否を判断し、エラー時は `STATE.change(exit_code, message)` で状態を更新する（AGENTS.md記載の「STATEグローバル定数」）。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `message_array` | Array<String> | `attr_accessor`。状態変更に関連するメッセージ群 |
| `exit_code` | Integer | `attr_accessor`。処理の終了コード |

---

## メソッド

### `initialize -> State`

`exit_code` を `SUCCESS` に、`message_array` を空配列に初期化する。

### `success? -> Boolean`

`exit_code == SUCCESS` かどうかを返す。

### `finish? -> Boolean`

`exit_code == FINISH` かどうかを返す。

### `change(exit_code, *message) -> State`

`exit_code` と `message_array` を更新する。

**Args**: `exit_code` — 新しい終了コード、`message` — 可変長のメッセージ
**Returns**: `self`（メソッドチェーン用）

### `show_message(_message = nil) -> Integer`

`message_array` を `Loggerxcm.show` に渡して表示し、現在の `exit_code` を返す。

**Args**: `_message` — アンダースコア接頭辞の通り未使用の引数
**Returns**: `exit_code`

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Loggerxcm` | メッセージ表示 |

---

## 設計上の注意

- `STATE = State.new` はモジュール `Mkspec` 直下のグローバル定数であり、全クラスがこの単一インスタンスを直接参照する共有可変状態になっている。処理の成否をメソッドの戻り値ではなくグローバル状態の副作用として伝える設計であり、テストの独立性や並行実行時の分離が難しい。
- `show_message` の引数 `_message` はアンダースコア接頭辞の通り未使用であり、呼び出し側（`Mkscript#check_state_and_show_useage_and_state_message`）が渡す配列は実質無視される。
