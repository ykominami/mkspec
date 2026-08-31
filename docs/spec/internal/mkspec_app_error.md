# MkspecAppError — クラス内部仕様書

**ファイル**: `lib/mkspec.rb`
**継承**: `MkspecError`

## 概要

アプリケーションレベルのエラー（入力データの検証失敗など、デバッグ用途というよりアプリケーションの実行結果として発生するエラー）を通知するための例外クラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `message_array` | Array | エラーに関する追加メッセージ群 |

---

## メソッド

### `initialize(msg = "My default message", message_array = []) -> MkspecAppError`

例外メッセージと追加メッセージ配列を設定する。

**Args**: `msg` — エラーメッセージ、`message_array` — 追加のメッセージ配列
**Returns**: 生成された `MkspecAppError` インスタンス

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `MkspecError` | 基底クラス |

---

## 設計上の注意

- `MkspecDebugError` と同様、`initialize` の実装は親クラス `MkspecError#initialize` と完全に同一である。`MkspecDebugError` との使い分け（デバッグ用かアプリケーション用か）はクラス名以外にコード上の強制力がなく、呼び出し側の判断に委ねられている。
