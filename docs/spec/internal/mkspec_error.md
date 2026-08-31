# MkspecError — クラス内部仕様書

**ファイル**: `lib/mkspec.rb`
**継承**: `StandardError`

## 概要

Mkspecフレームワーク固有のカスタム例外群の基底クラス。エラーメッセージに加えて、詳細情報を保持する `message_array` を持つ。`MkspecDebugError` と `MkspecAppError` はこのクラスを継承する。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `message_array` | Array | エラーに関する追加メッセージ群（デバッグ情報・バックトレース等が渡されることが多い） |

---

## メソッド

### `initialize(msg = "My default message", message_array = []) -> MkspecError`

例外メッセージと追加メッセージ配列を設定する。

**Args**: `msg` — エラーメッセージ、`message_array` — 追加のメッセージ配列
**Returns**: 生成された `MkspecError` インスタンス

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `StandardError` | 標準例外機構 |

---

## 設計上の注意

- コード全体で `raise Mkspec::MkspecAppError, "..."`（メッセージのみ）と `raise Mkspec::MkspecAppError.new("...", STATE.message_array)`（`message_array`も渡す）の両方の呼び出し方が混在しており、`message_array` が設定されるかどうかは呼び出し箇所依存になっている。
