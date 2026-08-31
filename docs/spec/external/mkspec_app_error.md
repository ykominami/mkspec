# 外部仕様書 — `MkspecAppError` クラス

**完全修飾名**: `Mkspec::MkspecAppError`
**種別**: 例外

本書は `docs/spec/internal/mkspec_app_error.md` の内部仕様書、`lib/mkspec.rb`・`lib/mkspec/*.rb` のソースコード、およびCLIエントリーポイント `bin/mkspec` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

アプリケーションレベルのエラー（入力データの検証失敗、必須設定の欠落など）を表す例外クラス。`TestCase`・`TestGroup`・`TestScript`・`TestScriptGroup`・`Setting`・`GlobalConfig`・`Item`・`Util`・`Mkscript` など、フレームワーク全体の入力検証で広く `raise` される。

## 2. フレームワーク上の位置付け

- クラス名は「アプリケーションレベルのMkspecエラー」を表す。
- 必須責務: `MkspecError` を継承し、`message_array` を保持できること。
- 基底クラス: `MkspecError`。
- 依存クラス: `TestCase`・`TestGroup`・`TestScript`・`TestScriptGroup`・`Setting`・`GlobalConfig`・`Item`・`Util`・`Mkscript` が本クラスを `raise` する。

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
- **戻り値**: 生成された `MkspecAppError` インスタンス
- **処理**: `message_array` を `@message_array` に設定し、`msg` を `StandardError#message` として設定する
- **状態変化・副作用**: なし
- **例外・エラー**: なし

## 7. 入出力・永続化

該当しない。

## 10. エラー処理・終了コード

`bin/mkspec` は `mkscript.create_files` のみを `begin...rescue` で囲い、`rescue Mkspec::MkspecAppError` 節で本例外を捕捉する。

- `Mkspec::STATE` が変更されていない（`STATE.success?` が真）場合: 終了コード `101`（`Mkspec::MKSPEC_APP_ERROR`）
- `Mkspec::STATE` が事前に変更済みの場合: `STATE.show_message` が返すその時点の終了コード

**`mkscript.init`（`TestScriptGroup#setup`によるTestCase/TestGroup/TestScriptの構築、`Setting#initialize`/`#setup`、`GlobalConfig#top_dir`、`Mkscript#init`自身の検証を含む）は `begin...rescue` の外側で実行される**ため、これらが送出する本例外は`bin/mkspec`のどの`rescue`節にも捕捉されず、Rubyの未捕捉例外としてプロセスが終了する（終了ステータスはRuby既定の`1`）。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `TestCase`/`TestGroup`/`TestScript`/`TestScriptGroup#initialize` が本例外を送出（`init`経由、`begin`の外側） | 未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `Setting#setup`（`GlobalConfig#top_dir`経由を含む）が本例外を送出（`init`経由、`begin`の外側） | 未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `Mkscript#init`自身の検証（`@gco.ost.top_dir`欠落）が本例外を送出（`begin`の外側） | 未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `Item`/`Root`起因のエラーが`Mkscript#make_spec_file`内で`STATE`を`CANNOT_MAKE_SPEC_FILE`に変更した後、本例外として再送出される（`create_files`経由、`begin`の内側） | `bin/mkspec`の`rescue Mkspec::MkspecAppError`節で捕捉 | 24（`CANNOT_MAKE_SPEC_FILE`） |
| `Mkscript#make_spec_file`が直接本例外を送出（`STATE`未変更の場合） | 同上の`rescue`節で捕捉 | 101（`MKSPEC_APP_ERROR`） |
| `Util#extract_with_eruby`が本例外を送出（`create_files`経由でItem/Rootのチェーン内、`begin`の内側） | 上記Item/Rootと同様の経路で捕捉 | 24（`CANNOT_MAKE_SPEC_FILE`、経路依存） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| 例外クラス本体 | `lib/mkspec.rb` の `Mkspec::MkspecAppError` |
| 主な送出元 | `lib/mkspec/testcase.rb`、`lib/mkspec/testgroup.rb`、`lib/mkspec/testscript.rb`、`lib/mkspec/testscriptgroup.rb`、`lib/mkspec/setting.rb`、`lib/mkspec/globalconfig.rb`、`lib/mkspec/item.rb`、`lib/mkspec/util.rb`、`lib/mkspec/mkscript.rb` |
| 捕捉元（CLI境界） | `bin/mkspec` |
