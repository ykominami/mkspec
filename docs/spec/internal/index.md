# 内部仕様書 — インデックス

`lib/**/*.rb` から生成したクラス別・モジュール別内部仕様書の一覧。

| ファイル | クラス/モジュール | 概要 |
|---------|--------|------|
| [mkspec.md](mkspec.md) | `Mkspec`（モジュール） | エラーコード定数群と例外クラス階層を定義し、全サブファイルをrequireするエントリーポイント |
| [not_string_inst_error.md](not_string_inst_error.md) | `NotStringInstError` | 非文字列インスタンスを示す例外クラス |
| [empty_string_error.md](empty_string_error.md) | `EmptyStringError` | 空文字列を示す例外クラス |
| [mkspec_error.md](mkspec_error.md) | `MkspecError` | Mkspecカスタム例外の基底クラス |
| [mkspec_debug_error.md](mkspec_debug_error.md) | `MkspecDebugError` | デバッグ関連エラーを示す例外クラス |
| [mkspec_app_error.md](mkspec_app_error.md) | `MkspecAppError` | アプリケーションレベルエラーを示す例外クラス |
| [mkspec/config.md](mkspec/config.md) | `Config` | 出力・テンプレート/データ・テストケース各ディレクトリの管理とセットアップ |
| [mkspec/globalconfig.md](mkspec/globalconfig.md) | `GlobalConfig` | global.yml・specific.ymlをマージしOpenStructで一元管理 |
| [mkspec/item.md](mkspec/item.md) | `Item` | YAMLデータとERubyテンプレートを合成する再帰的なコンテンツ単位 |
| [mkspec/mkscript.md](mkspec/mkscript.md) | `Mkscript` | CLIエントリーポイント。オプション解析からファイル生成までを統括 |
| [mkspec/root.md](mkspec/root.md) | `Root` | データYAMLからItem階層を構築しspec文字列を生成するエントリーポイント |
| [mkspec/setting.md](mkspec/setting.md) | `Setting` | テンプレートパス・データYAMLパス・テストケースID管理 |
| [mkspec/state.md](mkspec/state.md) | `State` | 終了コード・メッセージを一元管理するグローバル状態（`STATE`定数） |
| [mkspec/templatex.md](mkspec/templatex.md) | `Templatex` | ERubyテンプレートの生成・出力 |
| [mkspec/testcase.md](mkspec/testcase.md) | `TestCase` | 1件のテストケースを表すデータクラス |
| [mkspec/testgroup.md](mkspec/testgroup.md) | `TestGroup` | 複数のTestCaseをまとめるグループ |
| [mkspec/testscript.md](mkspec/testscript.md) | `TestScript` | 複数のTestGroupを束ね、TestCase総数の上限を管理 |
| [mkspec/testscriptgroup.md](mkspec/testscriptgroup.md) | `TestScriptGroup` | TSVファイルからTestScript群を構築 |
| [mkspec/version.md](mkspec/version.md) | `Mkspec`（モジュール） | バージョン定数`VERSION`を定義 |
| [mkspec/util.md](mkspec/util.md) | `Util` | ファイル操作・YAML処理・テンプレート処理の横断的ユーティリティ |
| [mkspec/loggerxcm0.md](mkspec/loggerxcm0.md) | `Loggerxcm0` | ファイル・標準出力へのログ出力の基底実装 |
| [mkspec/loggerxcm.md](mkspec/loggerxcm.md) | `Loggerxcm` | 標準的に使われるログ出力チャネル |
| [mkspec/loggerxcmcli.md](mkspec/loggerxcmcli.md) | `Loggerxcmcli` | CLI向けと思われるログ出力チャネル（未使用の可能性） |
| [mkspec/loggerxcmspec.md](mkspec/loggerxcmspec.md) | `Loggerxcmspec` | spec実行向けと思われるログ出力チャネル（未使用の可能性） |
