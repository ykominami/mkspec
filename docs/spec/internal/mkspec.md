# Mkspec — モジュール内部仕様書

**ファイル**: `lib/mkspec.rb`

## 概要

Mkspecフレームワーク全体で使うエラーコード定数群を定義し、カスタム例外クラス階層（`NotStringInstError`・`EmptyStringError`・`MkspecError`・`MkspecDebugError`・`MkspecAppError`、それぞれ個別の仕様書を参照）を宣言するエントリーポイントファイル。ファイル末尾で `version`・`globalconfig`・`root`・`setting`・`templatex`・`testcase`・`testgroup`・`testscript`・`testscriptgroup`・`mkscript`・`config`・`item`・`util`・`state` の各サブファイルを `require_relative` で読み込み、フレームワーク全体の名前空間を組み立てる役割も持つ。

---

## モジュールレベル定数・型

| 定数名 | 値 | 用途 |
|--------|----|------|
| `SUCCESS` | 0 | 処理成功 |
| `FINISH` | 1 | 正常終了（バージョン表示等） |
| `INVALID_CMDLINE_OPTION_ERROR` | 9 | コマンドラインオプション全般のエラー |
| `CMDLINE_OPTION_ERROR_O` | 10 | `-o` オプションエラー |
| `CMDLINE_OPTION_ERROR_T` | 11 | `-t` オプションエラー |
| `CMDLINE_OPTION_ERROR_C` | 12 | `-c` オプションエラー |
| `CMDLINE_OPTION_ERROR_S` | 13 | `-s` オプションエラー |
| `CMDLINE_OPTION_ERROR_L` | 14 | `-l` オプションエラー |
| `CMDLINE_OPTION_ERROR_D` | 15 | `-d` オプションエラー |
| `CMDLINE_OPTION_ERROR_G` | 16 | `-g` オプションエラー |
| `CMDLINE_OPTION_ERROR_X` | 17 | `-x` オプションエラー |
| `CMDLINE_OPTION_ERROR_Y` | 18 | `-y` オプションエラー |
| `CMDLINE_OPTION_ERROR_Z` | 19 | `-z` オプションエラー |
| `CMDLINE_OPTION_ERROR_DD` | 20 | `-d`系拡張オプションエラー |
| `CMDLINE_OPTION_ERROR_GG` | 21 | `-G` オプションエラー |
| `CMDLINE_OPTION_ERROR_LL` | 22 | `-L` オプションエラー |
| `CMDLINE_OPTION_ERROR_TT` | 23 | `-t`系拡張オプションエラー |
| `CANNOT_MAKE_SPEC_FILE` | 24 | SPECファイル作成失敗 |
| `CANNOT_WRITE_SPEC_FILE` | 25 | SPECファイル出力失敗 |
| `INVALID_YAML_FILE` | 26 | 不正なYAMLファイル |
| `CANNOT_FIND_DATA_YAML_FILE` | 30 | データYAMLファイル未発見 |
| `CANNOT_CONVERT_WITH_RUBO` | 41 | Rufoライブラリでの変換失敗 |
| `CANNOT_WRITE_YAML_FILE` | 50 | YAMLファイル出力失敗 |
| `CANNOT_FORMAT_WITH_ERUBY` | 60 | ERubyテンプレート展開失敗 |
| `MKSPEC_DEBUG_ERROR` | 100 | `MkspecDebugError`発生 |
| `MKSPEC_APP_ERROR` | 101 | `MkspecAppError`発生 |
| `MKSPEC_ENV_VARIABLE_ERROR_TOP_DIR_YAML_FNAME` | 201 | 環境変数`top_dir.yml`関連エラー |
| `MKSPEC_ENV_VARIABLE_ERROR_RESOLVED_TOP_DIR_YAML_FNAME` | 202 | 環境変数`resolved_top_dir.yml`関連エラー |
| `MKSPEC_ENV_VARIABLE_ERROR_SPECIFIC_YAML_FNAME` | 203 | 環境変数`specific.yml`関連エラー |
| `MKSPEC_ENV_VARIABLE_ERROR_GLOBAL_YAML_FNAME` | 204 | 環境変数`global.yml`関連エラー |
| `DEFAULT_LOG_DIR` | `"./logs"` | デフォルトのログディレクトリ |

各エラークラスの仕様は [not_string_inst_error.md](../not_string_inst_error.md)、[empty_string_error.md](../empty_string_error.md)、[mkspec_error.md](../mkspec_error.md)、[mkspec_debug_error.md](../mkspec_debug_error.md)、[mkspec_app_error.md](../mkspec_app_error.md) を参照。

---

## 設計上の注意

- AGENTS.md に記載されているエラーコード体系（9-23: CLIオプションエラー、24-26: 仕様ファイル生成・書き込みエラー、30: YAML未発見、41: RuboCop変換エラー、60: ERubyフォーマットエラー、100-101: デバッグ/アプリエラー、201-204: 環境変数エラー）はコード上にグルーピングを示すコメントがなく、定数の並び順とマジックナンバーのみで表現されている。
- `require_relative` の順序は依存関係（例: `globalconfig` が `Util`・`Loggerxcm` に依存する）を厳密には反映しておらず、`util` や `state` は他の多くのファイルより後にrequireされている。Rubyの定数解決は実行時に行われるため実害は出ていないが、読み手には依存順が把握しづらい。
