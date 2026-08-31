# Mkscript — クラス内部仕様書

**ファイル**: `lib/mkspec/mkscript.rb`
**継承**: なし

## 概要

mkspecのCLIエントリーポイント。コマンドラインオプション（`-o -t -c -s -l -d -i -g -x -y -z -G -L -n -v`）の解析、`GlobalConfig` / `Config` の初期化、TSVファイルからの `TestScriptGroup` 構築、テンプレート・データYAML・RSpec仕様ファイルの生成までの一連のフローを統括するオーケストレータ。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `gco` | GlobalConfig | `attr_accessor`。グローバル設定 |
| `new_count` | Boolean | `attr_accessor`。`-n` オプションに対応 |
| `@dirs_and_files` | Struct | 環境変数から解決したディレクトリ/ファイル情報 |
| `@opt` | OptionParser | CLIオプションパーサ |
| `@cmd_options` | Array<String> | `-c` に指定可能な値（`spec` / `tad` / `all`） |
| `@output_dir` / `@tsv_fname` / `@cmd` / `@start_char` / `@limit` / `@script_dir` / `@tad_dir` / `@global_yaml_fname` / `@original_output_dir` / `@target_cmd_1` / `@target_cmd_2` / `@specific_yaml_fname` / `@log_dir` | 各種 | CLIオプションまたは`GlobalConfig`由来の設定値 |
| `@config` | Config | 生成されたディレクトリ構成 |
| `@tsg` | TestScriptGroup | TSVから構築されたテストスクリプト群 |
| `@setting_and_testscript_array` | Array<[Setting, TestScript]> | 各TestScriptに対応するSettingの配列 |

---

## メソッド

### `initialize -> Mkscript`

環境変数からディレクトリ/ファイル情報を構築して `@dirs_and_files` に保持する。

### `check_state_and_show_useage_and_state_message -> Integer, nil`

`STATE` の状態（finish/failure）に応じてメッセージを表示し、終了コードを返す。

**Returns**: `Integer`（終了コード）、または `STATE` が成功状態の場合は `nil`

### `check_cli_options(argv) -> Object`

`OptionParser` で各オプションを解析し、`GlobalConfig` のセットアップと検証を行う。

処理フロー:
  1. `OptionParser` を構築しオプションをインスタンス変数に束縛する
  2. `argv` を `parse!` する（失敗時は `STATE` を `INVALID_CMDLINE_OPTION_ERROR` に変更して終了）
  3. `-v` が指定されていれば `STATE` を `FINISH` にして終了する
  4. `setup_globalconfig` を呼び `GlobalConfig` を構築する
  5. `validate_setting` で必須オプションの充足を検証する

**Args**: `argv` — コマンドライン引数配列
**Returns**: `STATE.change` の戻り値、または `validate_setting` の戻り値

### `validate_setting -> Object`

`GlobalConfig` の `OpenStruct`（`ost`）の値をデフォルトとしてCLIオプション未指定分を補完し、必須項目の充足を検証する。不足時は `STATE.change` で該当エラーコードに遷移する。

**Raises**: 明示的な例外はないが、実装上の欠陥により到達すると `NameError` になる箇所がある（設計上の注意を参照）

### `setup_globalconfig -> Object`

環境変数から `global_yaml` / `specific_yaml` のパスを解決し、`GlobalConfig` を生成して `@gco` に設定する。

処理フロー:
  1. `config_from_environmental_varialbes` で `init_hash` を取得する
  2. `global_yaml_fname` / `specific_yaml_fname` をCLIオプションまたは `@dirs_and_files` から補完する
  3. `global_yaml` の存在チェック（なければ `CMDLINE_OPTION_ERROR_G` で終了）
  4. `specific_yaml_fname` の存在チェック（なければ `CMDLINE_OPTION_ERROR_GG` で終了）
  5. `GlobalConfig.new` で `@gco` を構築する

### `config_from_environmental_varialbes -> Hash`

環境変数からディレクトリ/ファイル情報を再取得し、`top_dir.yml` と `resolved_top_dir.yml` からハッシュを作る。

### `valid_dir?(path) -> Boolean`

`path` が非空文字列かつ実在するディレクトリかを判定する。

### `init_sub(gco, config, tsv_path, tad_dir, start_char, limit, make_arg, cmd = nil) -> Boolean`

`Config#setup` を実行し、TSVファイルから `TestScriptGroup` を構築、`Setting`/`TestScript` の配列を作成する。

処理フロー:
  1. `config` が `nil` なら `false` を返す
  2. `config.setup` を実行し `@config` に保持する
  3. `STATE` が不成功なら `false` を返す
  4. `tsv_path` が存在しなければ `misc_dir` 配下のパスに置き換える
  5. `TestScriptGroup.new(...).setup` で `@tsg` を構築する
  6. `make_array_of_setting_and_testscript` で `@setting_and_testscript_array` を作成する

### `init -> Boolean`

`GlobalConfig` 未構築なら構築・検証を行い、`Config` インスタンスを生成して `init_sub` を呼び出す。

**Raises**: `MkspecAppError` — `@gco.ost.top_dir` が取得できない場合

### `make_array_of_setting_and_testscript(gco, tsg, config) -> Array<[Setting, TestScript]>`

`tsg` 内の各 `TestScript` に対応する `Setting` インスタンスを作成する。テストケースIDは `Setting` 間で連番になるよう引き継がれる。

### `create_setting_instance(gco, testscript, config, initail_testcase_id) -> Setting`

`Setting.new` を生成し `setup` を呼び出す。

### `create_files -> Array, nil`

`@cmd`（`spec` / `tad` / `all` / `all-2` / `tad-2` / `spec-2` / その他）に応じてテンプレート/データ生成とspec生成の実行有無を切り替え、実際に生成処理を実行する。

処理フロー:
  1. `@cmd` の値に応じて `template_and_data` / `spec` / `data_dir_index` を決定する
  2. `STATE` が不成功なら中断する
  3. `template_and_data` が真なら `create_all_template_and_data` を実行する
  4. `spec` が真なら `create_all_spec_file` を実行する

**Returns**: `[template_and_data, spec, data_dir_index]`、または `nil`

### `create_all_template_and_data(array) -> Array`

配列の各 `[setting, testscript]` について `make_template_and_data` を実行する。

### `make_template_and_data(setting) -> Boolean`

データYAML出力とテンプレート生成を行う。

### `make_template(setting) -> Boolean`

`Templatex` でセットアップし、成功すれば出力する。

### `create_all_spec_file(config, array) -> Boolean`

各 `[setting, testscript]` について `make_spec_file` を実行し、例外発生時は `STATE` を `CANNOT_MAKE_SPEC_FILE` に変更してループを中断する。最終的に `STATE` が不成功なら `MkspecDebugError` を送出する。

**Raises**: `Mkspec::MkspecDebugError` — `STATE` が不成功の場合
**Returns**: `error_count.zero?`

### `format_ruby_script(spec_file_pn, str) -> String`

`Mkscript.format`（Rufo）でRubyコードを整形する。失敗時はログを残し元の文字列をそのまま返す。

### `output_ruby_script(spec_file_pn, str) -> Boolean`

一時ファイル（サフィックス `_`）に書き込んでからリネームすることでアトミックにスペックファイルを出力する。

### `make_spec_file(config, setting, testscript) -> Boolean`

`Root#result` でスペック文字列を生成し、フォーマットしてファイルへ出力する。

処理フロー:
  1. `Root.new` でYAMLからspec文字列を生成する
  2. 例外発生時は `STATE` を `CANNOT_MAKE_SPEC_FILE` に変更する
  3. スペックファイル名・出力先パスを決定する
  4. `format_ruby_script` で整形する
  5. `output_ruby_script` で書き出す

### `self.format(code) -> String`

`Rufo::Formatter.format` を呼び出すクラスメソッド。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `OptionParser` | CLIオプション解析 |
| `Util` | 環境変数解決・ファイル操作 |
| `Loggerxcm` | ログ出力 |
| `GlobalConfig` / `Config` | 設定管理 |
| `TestScriptGroup` / `Setting` / `Templatex` / `Root` | ファイル生成フロー |
| `Rufo::Formatter` | Rubyコード整形 |
| `STATE` | 状態管理 |

---

## 設計上の注意

- `validate_setting` 内で `Mkspec::CMDLINE_OPTION_ERROR_I` という未定義の定数を参照している（`lib/mkspec.rb` には `CMDLINE_OPTION_ERROR_I` は定義されていない）。`-i`（`tad_dir`）未指定時にこの行に到達すると `NameError` になる。
- `validate_setting` の末尾で `argv_dup` および `argv` という、このメソッドのどこにも定義されていないローカル変数を参照している。到達すると `NameError` になる。
- `@target_cmd_2 ||= ost.tecsgen_merge_cmd` は `GlobalConfig` 側の実フィールド名（`tecsmerge_cmd`）と一致しておらず、`OpenStruct` が未定義フィールドとして `nil` を返すだけの無効なフォールバックになっている。
- `create_all_template_and_data` 内の `errors << x unless ret` の `x` は未定義でありNameErrorになる（`element` または `setting` の誤りと思われる）。
- `create_files` の `data_dir_index` は `"all-2"` / `"tad-2"` / `"spec-2"` の分岐でのみ明示的に `1` を設定し、他の分岐（`tad` / `spec` / デフォルト）では `0` または未設定のままであり、戻り値に含まれる以外の利用箇所が見当たらない。
