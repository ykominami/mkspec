# 外部仕様書 — `MkspecError` クラス

**完全修飾名**: `Mkspec::MkspecError`
**種別**: 例外（基底クラス）

本書は `docs/spec/internal/mkspec_error.md` の内部仕様書と `lib/mkspec.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

Mkspecフレームワーク固有のカスタム例外群（`MkspecDebugError`・`MkspecAppError`）の共通基底クラス。エラーメッセージに加えて、バックトレースや補足情報などの詳細情報を配列（`message_array`）として保持できる点が `StandardError` との違いである。本クラス自身が直接 `raise` されることは想定しておらず、責務はサブクラスに共通の初期化処理を提供することに限られる。

## 2. フレームワーク上の位置付け

- クラス名は「Mkspecフレームワーク固有のエラー」であることを表す。
- 必須責務: `message_array` を保持できる `StandardError` サブクラスであること。
- 基底クラス: `StandardError`（mkspec外部の型）。
- 依存クラス: `MkspecDebugError`、`MkspecAppError` が本クラスを継承する（依存の向きは子→親）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `StandardError` | 継承 | 例外機構への参加 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `message_array` | インスタンス属性（読み取り専用） | Array | `[]` | エラーに関する追加メッセージ群（デバッグ情報・バックトレース等が渡されることが多い） | 不可（読み取り専用） |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | エラーメッセージと追加メッセージ配列を設定して例外インスタンスを生成する |

## 6. 公開メソッド仕様

### 6.1 `initialize(msg = "My default message", message_array = [])`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: なし
- **引数**:
  - `msg`（String, 省略可） — 例外メッセージ。省略時は `"My default message"`
  - `message_array`（Array, 省略可） — 追加のメッセージ配列。省略時は空配列
- **戻り値**: 生成された `MkspecError`（またはそのサブクラス）インスタンス
- **処理**: `message_array` を `@message_array` に設定し、`msg` を `StandardError#message` として設定する
- **状態変化・副作用**: なし
- **例外・エラー**: なし

## 7. 入出力・永続化

該当しない。

## 10. エラー処理・終了コード

本クラス自体はコードベース内で直接 `raise` されておらず、常にサブクラス（`MkspecDebugError`／`MkspecAppError`）を介して送出される。終了コードの詳細はそれぞれの外部仕様書（[mkspec_debug_error.md](mkspec_debug_error.md)・[mkspec_app_error.md](mkspec_app_error.md)）を参照。

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| 例外クラス本体 | `lib/mkspec.rb` の `Mkspec::MkspecError` |
| サブクラス | `lib/mkspec.rb` の `Mkspec::MkspecDebugError`、`Mkspec::MkspecAppError` |
