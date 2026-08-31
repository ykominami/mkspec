# MkspecDebugError — クラス内部仕様書

**ファイル**: `lib/mkspec.rb`
**継承**: `MkspecError`

## 概要

デバッグ関連の状況（想定外の内部状態・データ不整合など）を通知するための例外クラス。フレームワーク内で最も頻繁に使われる例外の一つ。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `message_array` | Array | エラーに関する追加メッセージ群 |

---

## メソッド

### `initialize(msg = "My default message", message_array = []) -> MkspecDebugError`

例外メッセージと追加メッセージ配列を設定する。

**Args**: `msg` — エラーメッセージ、`message_array` — 追加のメッセージ配列
**Returns**: 生成された `MkspecDebugError` インスタンス

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `MkspecError` | 基底クラス |

---

## 設計上の注意

- `initialize` の実装は親クラス `MkspecError#initialize` と完全に同一であり、独自のオーバーライドを行う意味がない（親の `initialize` をそのまま利用しても同じ挙動になる）。
