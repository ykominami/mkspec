# 外部仕様書 — `MkspecDebugError` クラス

**完全修飾名**: `Mkspec::MkspecDebugError`
**種別**: 例外

本書は `docs/spec/internal/mkspec_debug_error.md` の内部仕様書、`lib/mkspec.rb`・`lib/mkspec/*.rb` のソースコード、およびCLIエントリーポイント `bin/mkspec` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

フレームワーク内部で想定外の内部状態・データ不整合を検出した際に送出される例外クラス。`Config`・`Item`・`Root`・`Templatex`・`Mkscript` など、ファイル生成フローの中核クラスから広く `raise` される、コードベース上最も使用頻度の高い例外の一つ。

## 2. フレームワーク上の位置付け

- クラス名は「デバッグ用途のMkspecエラー」を表す。
- 必須責務: `MkspecError` を継承し、`message_array` を保持できること。
- 基底クラス: `MkspecError`。
- 依存クラス: `Config`・`Item`・`Root`・`Templatex`・`Setting`・`Mkscript` が本クラスを `raise` する（依存の向きは各クラス→本クラス）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `MkspecError` | 継承 | 共通の初期化処理・`message_array`保持機構 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `message_array` | インスタンス属性（読み取り専用） | Array | `[]` | エラーに関する追加メッセージ群 | 不可（読み取り専用） |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | エラーメッセージと追加メッセージ配列を設定して例外インスタンスを生成する（`MkspecError#initialize`と同一実装） |

## 6. 公開メソッド仕様

### 6.1 `initialize(msg = "My default message", message_array = [])`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: なし
- **引数**: `msg`（String, 省略可）、`message_array`（Array, 省略可）
- **戻り値**: 生成された `MkspecDebugError` インスタンス
- **処理**: `message_array` を `@message_array` に設定し、`msg` を `StandardError#message` として設定する
- **状態変化・副作用**: なし
- **例外・エラー**: なし

## 7. 入出力・永続化

該当しない（例外オブジェクト自体はファイル等を扱わない）。

## 10. エラー処理・終了コード

CLIエントリーポイント `bin/mkspec` は `mkscript.create_files` の呼び出しのみを `begin...rescue` で囲っており、`rescue Mkspec::MkspecDebugError` 節で本例外を捕捉する。捕捉時の終了コードは以下の規則で決まる。

- `Mkspec::STATE` が変更されていない（`STATE.success?` が真）場合: 終了コード `100`（`Mkspec::MKSPEC_DEBUG_ERROR`）
- `Mkspec::STATE` が事前に変更済みの場合: `STATE.show_message` が返すその時点の終了コード（例: `CANNOT_MAKE_SPEC_FILE`=24 等）

ただし、**`mkscript.init`（`Config#setup`を含む）の呼び出しは `bin/mkspec` の `begin...rescue` の外側で実行される**ため、`Config#setup`が送出する本例外はどの `rescue`節にも捕捉されず、Rubyの未捕捉例外としてプロセスがバックトレースを出力して終了する（終了ステータスはRubyの既定である `1`。フレームワークが定義する`100`にはならない）。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `Config#setup` が本例外を送出（`init`経由、`begin`の外側） | 未捕捉例外としてプロセス終了 | 1（Ruby既定。フレームワーク定義値ではない） |
| `Item`/`Root` が本例外を送出し、`Mkscript#make_spec_file`内の`rescue StandardError`で捕捉され`STATE`が`CANNOT_MAKE_SPEC_FILE`に変更された後、`MkspecAppError`として再送出される | `bin/mkspec`の`rescue Mkspec::MkspecAppError`節で捕捉 | 24（`CANNOT_MAKE_SPEC_FILE`） |
| `Templatex#output` が本例外を送出（`create_all_template_and_data`経由、`create_files`は`begin`の内側） | `bin/mkspec`の`rescue Mkspec::MkspecDebugError`節で捕捉。`STATE`未変更のため | 100（`MKSPEC_DEBUG_ERROR`） |
| `Mkscript#format_ruby_script`/`#output_ruby_script`/`#create_all_spec_file` が本例外を送出 | 同上の`rescue`節で捕捉。直前の`STATE.change`内容に応じて終了コードが変わる | `STATE`が未変更なら100、変更済みなら`CANNOT_WRITE_SPEC_FILE`(25)等その時点の値 |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| 例外クラス本体 | `lib/mkspec.rb` の `Mkspec::MkspecDebugError` |
| 主な送出元 | `lib/mkspec/config.rb`、`lib/mkspec/item.rb`、`lib/mkspec/root.rb`、`lib/mkspec/templatex.rb`、`lib/mkspec/setting.rb`、`lib/mkspec/mkscript.rb` |
| 捕捉元（CLI境界） | `bin/mkspec` |
