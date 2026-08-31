# 外部仕様書 — `Mkspec` モジュール

**完全修飾名**: `Mkspec`
**種別**: モジュール（名前空間・定数定義）

本書は `docs/spec/internal/mkspec.md` の内部仕様書と `lib/mkspec.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する（対象がクラスではなくモジュールであるため、クラス固有の章「継承」「クラス定数」等は本書の性質に合わせて読み替える）。

## 1. 概要

Mkspecフレームワーク全体の名前空間であり、エラーコード定数群と例外クラス階層（[MkspecError](mkspec_error.md)・[MkspecDebugError](mkspec_debug_error.md)・[MkspecAppError](mkspec_app_error.md)・[NotStringInstError](not_string_inst_error.md)・[EmptyStringError](empty_string_error.md)）を宣言する。利用者は主にCLIエントリーポイント（`bin/mkspec`）および `lib/mkspec/` 配下の各クラスであり、本モジュール自身は処理ロジックを持たず、定数と例外クラスの提供、および全サブファイルの読み込みが責務である。

## 2. フレームワーク上の位置付け

- 名称は本gem名 `mkspec` に由来する。
- 必須責務: フレームワーク全体で共有するエラーコード定数と例外クラスを提供すること。
- 依存クラス: `lib/mkspec/` 配下の全クラス（`version`・`globalconfig`・`root`・`setting`・`templatex`・`testcase`・`testgroup`・`testscript`・`testscriptgroup`・`mkscript`・`config`・`item`・`util`・`state`）を `require_relative` で読み込む。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| 各サブファイルのクラス群 | 参照（require） | フレームワーク全体の名前空間構成 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `SUCCESS` | モジュール定数 | Integer | 0 | 処理成功 | 不可 |
| `FINISH` | モジュール定数 | Integer | 1 | 正常終了（バージョン表示等） | 不可 |
| `INVALID_CMDLINE_OPTION_ERROR` | モジュール定数 | Integer | 9 | コマンドラインオプション全般のエラー | 不可 |
| `CMDLINE_OPTION_ERROR_O`〜`_TT` | モジュール定数 | Integer | 10〜23 | 各CLIオプション（`-o -t -c -s -l -d -g -x -y -z`等）固有のエラー | 不可 |
| `CANNOT_MAKE_SPEC_FILE` | モジュール定数 | Integer | 24 | SPECファイル作成失敗 | 不可 |
| `CANNOT_WRITE_SPEC_FILE` | モジュール定数 | Integer | 25 | SPECファイル出力失敗 | 不可 |
| `INVALID_YAML_FILE` | モジュール定数 | Integer | 26 | 不正なYAMLファイル | 不可 |
| `CANNOT_FIND_DATA_YAML_FILE` | モジュール定数 | Integer | 30 | データYAMLファイル未発見 | 不可 |
| `CANNOT_CONVERT_WITH_RUBO` | モジュール定数 | Integer | 41 | Rufoライブラリでの変換失敗 | 不可 |
| `CANNOT_WRITE_YAML_FILE` | モジュール定数 | Integer | 50 | YAMLファイル出力失敗 | 不可 |
| `CANNOT_FORMAT_WITH_ERUBY` | モジュール定数 | Integer | 60 | ERubyテンプレート展開失敗 | 不可 |
| `MKSPEC_DEBUG_ERROR` | モジュール定数 | Integer | 100 | `MkspecDebugError`発生時の既定終了コード | 不可 |
| `MKSPEC_APP_ERROR` | モジュール定数 | Integer | 101 | `MkspecAppError`発生時の既定終了コード | 不可 |
| `MKSPEC_ENV_VARIABLE_ERROR_TOP_DIR_YAML_FNAME`〜`_GLOBAL_YAML_FNAME` | モジュール定数 | Integer | 201〜204 | 環境変数関連エラー | 不可 |
| `DEFAULT_LOG_DIR` | モジュール定数 | String | `"./logs"` | デフォルトのログディレクトリ | 不可 |

## 5. 公開メソッド一覧

該当なし（本モジュールは定数定義とrequireのみを行い、メソッドを定義しない）。

## 7. 入出力・永続化

`require_relative` により `lib/mkspec/` 配下の各Rubyソースファイルを読み込む。

## 10. エラー処理・終了コード

本モジュールが定義する定数は、CLIエントリーポイント `bin/mkspec` および各クラスの `raise`/`STATE.change` 呼び出しで使用される終了コードの一覧である。個々の事象と終了コードの対応は、各クラスの外部仕様書（特に [mkscript.md](mkspec/mkscript.md)、[mkspec_debug_error.md](mkspec_debug_error.md)、[mkspec_app_error.md](mkspec_app_error.md)）を参照。

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| 定数・例外クラス定義本体 | `lib/mkspec.rb` |
| サブファイル一式 | `lib/mkspec/*.rb` |
