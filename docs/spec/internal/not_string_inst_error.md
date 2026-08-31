# NotStringInstError — クラス内部仕様書

**ファイル**: `lib/mkspec.rb`
**継承**: `StandardError`

## 概要

文字列型であることが期待される値に非文字列が渡された場合を示すために定義された例外クラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `attr` | 常に `nil` | `attr_reader` で公開されるが、実際には代入されない（詳細は設計上の注意参照） |

---

## メソッド

### `initialize(msg = "My default message", _message_array = []) -> NotStringInstError`

例外メッセージを設定する。

**Args**: `msg` — エラーメッセージ、`_message_array` — アンダースコア接頭辞の通り未使用の引数
**Returns**: 生成された `NotStringInstError` インスタンス

---

## 設計上の注意

- `initialize` 内の `@attr = attr` は、`attr_reader :attr` が生成したゲッターメソッド `attr` を呼び出しているだけであり、右辺の `attr` はこの時点でまだ `@attr` が未設定のため常に `nil` を返す。結果として `@attr` は常に `nil` のままになり、実質的に意味のない自己代入になっている（バグの疑い）。
- 同じファイル内の `EmptyStringError` や `MkspecError` 系のクラスは `message_array` を保持するのに対し、本クラスのみ独自の `attr` という属性を持つなど、例外クラス間で保持する情報に一貫性がない。
