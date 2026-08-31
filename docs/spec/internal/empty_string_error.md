# EmptyStringError — クラス内部仕様書

**ファイル**: `lib/mkspec.rb`
**継承**: `StandardError`

## 概要

空文字列が渡された場合を示すために定義された例外クラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `message_array` | Array | エラーに関する追加メッセージ群 |

---

## メソッド

### `initialize(msg = "My default message", message_array = []) -> EmptyStringError`

例外メッセージと追加メッセージ配列を設定する。

**Args**: `msg` — エラーメッセージ、`message_array` — 追加のメッセージ配列
**Returns**: 生成された `EmptyStringError` インスタンス

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `StandardError` | 標準例外機構 |

---

## 設計上の注意

特になし。
