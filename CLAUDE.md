# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

**mkspec** は、ERuby（Embedded Ruby）テンプレートとYAMLファイルを使用してRSpec仕様ファイルを自動生成するRubyジェムです。

## コマンド

```bash
# テスト実行
bundle exec rake spec

# コード品質チェック
bundle exec rake rubocop

# デフォルト（spec + rubocop）
bundle exec rake

# 単一テストファイルの実行
bundle exec rspec spec/mkspec_util_spec.rb

# 特定のテスト例を実行
bundle exec rspec spec/mkspec_util_spec.rb -e "テスト名"
```

## 必要な環境変数

テスト実行時に以下の環境変数が必要です：

| 変数名 | 例 |
|--------|-----|
| `MKSPEC_OUTPUT_DIR` | `./test_output` |
| `MKSPEC_DATA_DIR` | `./test_data` |
| `MKSPEC_LOG_DIR` | `./test_output/logs` |
| `MKSPEC_GLOBAL_YAML_FNAME` | `./test_data/global.yml` |
| `MKSPEC_TOP_DIR_YAML_FNAME` | `./test_data/top_dir.yml` |
| `MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME` | `./test_data/_resolved/top_dir.yml` |
| `MKSPEC_SPECIFIC_YAML_FNAME` | `./test_data/specific.yml` |

## アーキテクチャ

### ファイル生成フロー

```
Mkscript（CLIエントリーポイント・オーケストレータ）
  ├── GlobalConfig（global.yml + specific.yml からOpenStructで設定を一元管理）
  ├── Config（出力・テンプレート・テストケースディレクトリのパス管理）
  ├── TestScriptGroup（TSVファイルからテストスクリプト群を構築）
  │    └── TestScript → TestGroup → TestCase
  ├── Setting（各TestScriptのテンプレートパス・データYAMLパス・テストケースID管理）
  └── Templatex（ERubyテンプレート生成・出力）
       └── Root → Item（YAMLデータとERubyテンプレートを合成してspec出力）
```

### 主要ファイルの役割

| ファイル | 役割 |
|---------|------|
| `lib/mkspec/mkscript.rb` | CLIオプション解析（`-o -t -c -s -l -d -g -G -L -n`）、初期化、ファイル生成フロー |
| `lib/mkspec/globalconfig.rb` | global.yml・specific.yml をマージしOpenStructで保持。定数キー群を定義 |
| `lib/mkspec/util.rb` | ファイル操作・YAML処理・テンプレート処理のユーティリティ（最大のファイル）。`adjust_dirs_and_files`で環境変数からパス群を構築 |
| `lib/mkspec/config.rb` | 出力・テンプレート・テストケースディレクトリ設定 |
| `lib/mkspec/setting.rb` | テンプレートパス、データYAMLパス、テストケースID管理 |
| `lib/mkspec/root.rb` | データYAMLを読み込みItem階層を構築してspec文字列を生成 |
| `lib/mkspec/item.rb` | ERubyテンプレートとYAMLデータを合成する再帰的なコンテンツ単位 |
| `lib/mkspec/state.rb` | グローバル定数 `STATE`（`State`インスタンス）で終了コードとメッセージを一元管理 |
| `lib/mkspec/loggerxcm.rb` | ファイルおよびstdoutへのログ出力 |
| `lib/mkspec.rb` | エラーコード定数・カスタム例外クラス定義、全サブファイルのrequire |

### STATEグローバル定数

`lib/mkspec/state.rb` で `STATE = State.new` として定義されたシングルトン的なグローバル状態管理オブジェクト。
各処理は `STATE.success?` で継続判断し、エラー時は `STATE.change(exit_code, message)` で状態を更新する。

### CLIオプション（`-c`コマンド）

`-c` オプションには `spec`・`tad`・`all` の3値が有効：
- `spec`: RSpec仕様ファイルのみ生成
- `tad`: テンプレートとデータYAMLのみ生成
- `all`: テンプレート・データYAML生成後にRSpec仕様ファイル生成

### エラーコード体系

`lib/mkspec.rb` でエラーコードが定義されています：
- `0`: SUCCESS
- `1`: FINISH（バージョン表示等の正常終了）
- `9-23`: CLIオプションエラー
- `24-26`: 仕様ファイル生成・書き込みエラー
- `30`: YAMLファイル未発見
- `41`: RuboCop変換エラー
- `60`: ERubyフォーマットエラー
- `100-101`: デバッグ・アプリエラー
- `201-204`: 環境変数エラー

### テストデータ形式

テストケースはTSV形式で定義（`test_data/test/misc/testlist*.txt`）：
```
グループ名    テストケース番号
data-normal   1
data-abnormal 1-5
```

## RuboCop設定

- TargetRubyVersion: 3.0
- LineLength最大: 250文字
- ClassLength最大: 400行
- 日本語コメント許可
- 除外対象: `test_data/**`, `bin/**`
