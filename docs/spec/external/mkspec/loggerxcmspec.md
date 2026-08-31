# 外部仕様書 — `Loggerxcmspec` クラス

**完全修飾名**: `Mkspec::Loggerxcmspec`
**種別**: 通常クラス（空のサブクラス）

本書は `docs/spec/internal/mkspec/loggerxcmspec.md` の内部仕様書、`lib/mkspec/loggerxcm.rb`、および呼び出し元である `bin/mkspec` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

`Loggerxcm0`を継承した、spec実行時のエラー出力向けと思われる名前を持つログ出力チャネル。クラス本体は空で`Loggerxcm0`の全クラスメソッドを継承するのみだが、`lib`配下では未参照である一方、CLIエントリーポイント`bin/mkspec`の`output_error_message`関数から`Mkspec::Loggerxcmspec.error(mes)`として実際に利用されている。

## 2. フレームワーク上の位置付け

- クラス名は「spec実行時のロガー」を意図した命名と推測される。
- 必須責務: `Loggerxcm0`の実装をそのまま利用可能にすること。
- 基底クラス: `Loggerxcm0`。
- 利用元: `bin/mkspec`（`Mkscript#create_files`の各種`rescue`節でのエラーメッセージ出力）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Loggerxcm0` | 継承 | ログ出力の実装一式 |

## 4. 公開属性・定数

`Loggerxcm0`の§4を参照（追加の属性・定数はない）。

## 5. 公開メソッド一覧

`Loggerxcm0`の§5を参照（追加・オーバーライドするメソッドはない）。

## 9. 不変条件・状態遷移

`Loggerxcm0`のクラスインスタンス変数はサブクラス間で共有されないため、本クラスは`Loggerxcm`等とは独立したログファイル/標準出力状態を持つ。ただし`bin/mkspec`は本クラスの`init`を呼び出していないため、`@valid`は常に`false`のままであり、`error`呼び出しは実質的に無効（ログ出力されない）ままである点に注意（`Loggerxcm0#error`は`@valid`が`false`の間は実際の出力を行わない）。

## 10. エラー処理・終了コード

本クラス自体は例外を送出しない。`bin/mkspec`は本クラスの`init`を呼んでいないため、`Mkscript#create_files`で捕捉した例外を`output_error_message`経由で`Loggerxcmspec.error`に渡しても、`@valid`が`false`のため実際にはログファイル・標準出力のいずれにも記録されない（`puts`によるコンソール出力は別途行われるため、ユーザーへのエラーメッセージ表示自体は成立する）。終了コードそのものはこの呼び出しの成否に左右されない。

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/loggerxcm.rb` の `Mkspec::Loggerxcmspec` |
| 利用元 | `bin/mkspec` の `output_error_message` |
