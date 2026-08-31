# 外部仕様書 — `Setting` クラス

**完全修飾名**: `Mkspec::Setting`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/setting.md` の内部仕様書と `lib/mkspec/setting.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

1つの`TestScript`に対応する設定を保持し、テンプレートパス・データYAMLパスの決定、RSpecの`describe`/`context`構造をハッシュとして構築し、データYAMLファイルとして出力するクラス。責務外の事項として、構築したハッシュを実際のERubyテンプレートに変換する処理（`Templatex`/`Root`/`Item`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「1つの出力単位に対する設定」を表す。
- 必須責務: `TestScript`の構造からRSpec用データYAMLを構築・出力すること。
- 基底クラス: なし。
- 依存クラス: `TestScript`・`TestGroup`・`TestCase`（入力構造）、`GlobalConfig`（キー定数解決）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `TestScript` | 参照 | 対応する出力単位の構造取得 |
| `TestGroup` | 参照 | `test_groups`の反復処理 |
| `TestCase` | 参照 | `test_cases`の反復処理 |
| `GlobalConfig` | 参照 | `get_key_of_*`によるハッシュキー名解決 |
| `Util` | 参照 | 文字列検証 |
| `State` | 参照 | `STATE.message_array`の利用 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `template_path` | インスタンス属性（読み取り専用） | Pathname | - | テンプレート本体（`content.txt`）のパス | 不可 |
| `testscript` | インスタンス属性（読み取り専用） | TestScript | - | 対応する`TestScript` | 不可 |
| `data_yaml_path` | インスタンス属性（読み取り専用） | Pathname | - | データYAMLの出力先パス | 不可 |
| `func_name_of_make_arg` | インスタンス属性（読み取り専用） | String | - | make引数生成に使う関数名 | 不可 |
| `lt_id` | インスタンス属性（読み取り専用） | Integer | - | テストケースIDの連番カウンタ | 不可（`next_testcase_id`経由で内部更新） |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | テンプレート/データYAMLのパスを決定し初期状態を構築する |
| `setup` | インスタンス | RSpecの`describe`/`context`構造を構築する |
| `output_data_yamlfile` | インスタンス | 構築したハッシュをYAMLファイルへ出力する |
| `next_testcase_id` | インスタンス | テストケースIDを1つ進める |

## 6. 公開メソッド仕様

### 6.1 `initialize(global_config, testscript, config, initail_testcase_id)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `global_config`が非`nil`、`testscript.name`が非空文字列、`config`が非`nil`、`global_config.make_arg`が非空文字列であること（いずれかを満たさない場合、後述のとおりエラーにならず初期化が中断される）
- **引数**: `global_config`（GlobalConfig）、`testscript`（TestScript）、`config`（Config）、`initail_testcase_id`（Integer） — 開始テストケースID
- **戻り値**: 生成された`Setting`インスタンス（前提条件を満たさない場合、一部属性が未設定のまま返る）
- **処理**: テンプレート/データディレクトリ配下に`testscript`名のサブディレクトリを作成し、テンプレートパス・データYAMLパスを決定する
- **状態変化・副作用**: テンプレート/データディレクトリ配下にサブディレクトリを作成する（ファイルシステムへの副作用）
- **例外・エラー**: 前提条件を満たさない場合でも例外は送出されない（設計上の注意参照。後続の`setup`呼び出し時に`NoMethodError`等を招きうる）

### 6.2 `setup(desc)`

- **種別**: インスタンスメソッド
- **前提条件**: `initialize`が正常に完了していること（`func_name_of_make_arg`/`lt_id`が設定済みであること）
- **引数**: `desc`（String） — RSpec `describe`の説明文字列
- **戻り値**: Boolean（構築中に発生したエラー件数が0かどうか）
- **処理**:
  1. `rspec_describe_head`/`rspec_describe_end`/`rspec_describe_context_end`の固定エントリを構築する
  2. `testscript.test_groups`の各グループについて、コンテキスト構築・make引数登録・テストケース構築を行う
- **状態変化・副作用**: 内部ハッシュ（データYAML出力の元）が構築される
- **例外・エラー**: `MkspecAppError` — `test_group.name`が空の場合。`MkspecDebugError` — テストケースの`test_1`が数値の場合

### 6.3 `output_data_yamlfile()`

- **種別**: インスタンスメソッド
- **前提条件**: `setup`が完了していること
- **引数**: なし
- **戻り値**: Boolean（成功時`true`）
- **処理**: 内部ハッシュをYAML形式で`data_yaml_path`へ書き出す
- **状態変化・副作用**: データYAMLファイルが作成される
- **例外・エラー**: 実装上の欠陥により、書き込み失敗時の例外送出処理自体が`NoMethodError`を引き起こす（§10参照）

### 6.4 `next_testcase_id()`

- **種別**: インスタンスメソッド
- **戻り値**: Integer（インクリメント後の`lt_id`）
- **状態変化・副作用**: `lt_id`が1増加する

## 7. 入出力・永続化

- **出力ファイル**: データYAMLファイル（`data_yaml_path`、例: `<name>.yml`）

## 9. 不変条件・状態遷移

- `setup`は`initialize`が正しく完了していることを暗黙の前提とする（明示的な事前条件チェックはない）。
- `lt_id`は`Mkscript#make_array_of_setting_and_testscript`により、`Setting`インスタンス間で連番が引き継がれる（各`TestScript`内で一意なテストケースIDを保証するため）。

## 10. エラー処理・終了コード

`Setting.new`/`#setup`は`Mkscript#create_setting_instance`（`make_array_of_setting_and_testscript`→`init_sub`→`Mkscript#init`経由、CLIの`begin...rescue`の**外側**）から呼び出される。一方、`output_data_yamlfile`は`Mkscript#make_template_and_data`（`create_files`→`create_all_template_and_data`経由、CLIの`begin`の**内側**）から呼び出される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `setup`が`MkspecAppError`/`MkspecDebugError`を送出（`init`経由） | `bin/mkspec`では未捕捉、Rubyの未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `GlobalConfig#top_dir`経由で`MkspecAppError`が送出される（`setup`内） | 同上 | 1（Ruby既定） |
| `output_data_yamlfile`の書き込み失敗（`create_files`経由、`begin`の内側） | `STATE`が`CANNOT_WRITE_YAML_FILE`(50)に変更された直後、例外送出コードの実装誤り（`.new`なし）により`NoMethodError`が発生し、`bin/mkspec`の`rescue StandardError`で捕捉される | 50（`CANNOT_WRITE_YAML_FILE`、`STATE`が事前に変更されているため） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/setting.rb` の `Mkspec::Setting` |
