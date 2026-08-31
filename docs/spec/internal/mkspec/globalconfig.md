# GlobalConfig — クラス内部仕様書

**ファイル**: `lib/mkspec/globalconfig.rb`
**継承**: なし

## 概要

`global.yml` と `specific.yml` を読み込みマージして、`OpenStruct`（`@ost`）としてフレームワーク全体の設定値を一元管理する。YAMLハッシュのキー名を表す多数の文字列定数（`*_KEY`）を定義し、キー名の直書きを避けるためのアクセサ（`get_key_of_*`）を提供する。

---

## クラス定数

| 定数名 | 値 | 説明 |
|--------|----|------|
| `ORIGINAL_OUTPUT_ROOT_DIR_KEY` | `"original_output_root_dir"` | 出力ルートディレクトリを表すキー |
| `SPECIFIC_YAML_FNAME_KEY` | `"specific_yaml_fname"` | specific YAMLファイルを表すキー |
| `GLOBAL_YAML_FNAME_KEY` | `"global_yaml_fname"` | global YAMLファイルを表すキー |
| `ORIGINAL_OUTPUT_DIR_KEY` | `"original_output_dir"` | 出力ディレクトリを表すキー |
| `TEST_DIR` | `"test"` | テストディレクトリ名 |
| `RESULT_FNAME` | `"result.txt"` | 結果ファイル名 |
| `TEST_DATA_DIR` | `"_test_data"` | テストデータディレクトリ名 |
| `MISC_DIR` | `"misc"` | miscディレクトリ名 |
| `TSV_FNAME` | `"testlist-x.txt"` | デフォルトTSVファイル名 |
| `TSV_FNAME_2` | `"t.txt"` | 予備のTSVファイル名 |
| `CONTENT_FNAME` | `"content.txt"` | テンプレート本体ファイル名 |
| `TESTDATA_FNAME` | `"testdata.txt"` | テストデータファイル名 |
| `YAML_FNAME` | `"a.yml"` | デフォルトデータYAMLファイル名 |
| `OUTPUT_SCRIPT_DIR` | `"script"` | スクリプト出力ディレクトリ名 |
| `OUTPUT_TEMPLATE_AND_DATA_DIR` | `"template_and_data"` | テンプレート/データ出力ディレクトリ名 |
| `OUTPUT_TEST_CASE_DIR` | `"test_case"` | テストケース出力ディレクトリ名 |
| `TEST_CASE_ARCHIVE_DIR` | `"_test_case_archive"` | テストケースアーカイブディレクトリ名 |
| `TEST_ARCHIVE_DIR` | `"_test_archive"` | テストアーカイブディレクトリ名 |
| `TSV_PATH_INDEX_KEY` / `TSV_PATH_ARRAY_KEY` | `"tsv_path_index"` / `"tsv_path_array"` | TSVパス関連のキー |
| `MAKE_ARG_KEY` | `"make_arg"` | make引数を表すキー |
| `TOP_DIR_KEY` | `"top_dir"` | トップディレクトリを表すキー |
| `LOG_DIR_KEY` | `"log_dir"` | ログディレクトリを表すキー |
| `MAKE_CMDLINE_1_KEY` | `"make_cmdline_1"` | コマンドライン作成を表すキー |
| `TARGET_CMD_1_KEY` / `TARGET_CMD_2_KEY` | `"target_cmd_1"` / `"target_cmd_2"` | 対象コマンドのパスを表すキー |
| `TECSPATH_KEY` | `"tecspath"` | tecspathを表すキー |
| `TECSPATH_CMD_PATH_KEY` | `"tecspath_cmd_path"` | tecspath_cmd_pathを表すキー |
| `TECSGEN_CMD_PATH_KEY` | `"tecsgen_cmd_path"` | tecsgen_cmdのパスを表すキー |
| `TEST_CASE_DIR_KEY` | `"test_case_dir"` | テストケースディレクトリを表すキー |
| `TECSGEN_CMD_KEY` | `"tecsgen_cmd"` | tecsgenコマンドを表すキー |
| `CMD_KEY` | `"cmd"` | cmdを表すキー |
| `START_CHAR_KEY` | `"start_char"` | 開始文字を表すキー |
| `LIMIT_KEY` | `"limit"` | 上限を表すキー |
| `TEST_MISC_DIR` / `TEST_INCLUDE_DIR` / `TEST_CYGWIN_DIR` / `TEST_CYGWIN3_DIR` | `"_test_misc"` 等 | 補助テストディレクトリ名 |
| `DEFAULT_TOP_DIR` | `"."` | デフォルトのトップディレクトリ |

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `ost` | OpenStruct | 設定値を保持するメインの構造体（`attr_accessor`） |
| `specific_hash` | Hash | specific.ymlの内容（`attr_accessor`） |
| `@global_hash` | Hash | global.ymlとspecific_hashをマージした内容 |
| `@new_count` | Boolean | `-n` オプション相当のフラグ |

---

## メソッド

### `initialize(new_count, init_hash, dirs_and_files, target_cmd_1 = nil, target_cmd_2 = nil) -> GlobalConfig`

global.yml / specific.yml を読み込み、`@ost` を構築する。

処理フロー:
  1. `global_yaml` の Pathname を取得し、存在しなければ処理を中断する（`@ost` が設定されないまま `return`）
  2. `specific_yaml` を読み込み `@specific_hash` を得る（配列であれば先頭要素を採用）
  3. `global_yaml` の内容を `@specific_hash` とマージして `@global_hash` を作る
  4. `@global_hash` が空なら中断する
  5. `init_for_common` で `@specific_hash` を `@global_hash` にマージする
  6. `init_for_ost` で `@ost`（OpenStruct）を構築する
  7. `init_for_output` でログ・データ・出力ディレクトリを `@ost` に設定する
  8. `setup` で残りの派生パス（テストルート・TSV・出力ディレクトリなど）を `@ost` に設定する

**Raises**: 明示的な例外は投げず、検証失敗時は `return` で処理を中断する（呼び出し側は `@ost` が未構築のままになる点に注意）

### `init_for_output(dirs_and_files) -> Boolean`

`@ost.log_dir_pn` / `data_top_dir_pn` / `output_data_top_dir_pn` などを設定し、ログディレクトリが存在すれば作成する。

**Returns**: ログディレクトリが存在しない場合 `false`、それ以外は `true`

### `setup(ost) -> nil`

テストルート・出力先・TSVファイル名などの派生パスを `ost` に設定する。

処理フロー:
  1. `test_root_dir_pn` を算出する
  2. `original_output_root_dir` の有無で `target_parent_dir_pn` の算出方法を分岐する
  3. `_test_data` / `misc` ディレクトリと各種TSVパスを設定する
  4. 環境変数 `MKSPEC_OUTPUT_DIR` を優先して `output_dir` / `output_dir_pn` を決定する
  5. `output_template_and_data_dir_pn` / `output_script_dir_pn` / `output_test_case_root_dir_pn` を設定する

### `init_for_common(specific_hash) -> Boolean`

`specific_hash` が空でなければ `@global_hash` にマージする。

### `init_for_ost(target_cmd_1, target_cmd_2, init_hash, global_yaml_pna) -> Boolean`

`@global_hash` の値を `@ost` の各属性へコピーし、トップディレクトリや対象コマンドのパスを解決する。

処理フロー:
  1. `@global_hash` の値を `@ost` の各属性にコピーする
  2. `top_dir_original` を算出し `top_dir_pn`（絶対パス）を設定する
  3. `-n` オプション相当（`@new_count`）が指定されている場合、`original_output_dir` のベース名が `<文字列><数字>` パターンにマッチすれば、既存ディレクトリと衝突しない番号までインクリメントして新しいディレクトリ名を生成する
  4. `target_cmd_1` / `target_cmd_2` の指定有無を検証する（片方のみの指定はエラー）
  5. `Util.get_path` でトップディレクトリ直下・`bin/`・`exe/` から対象コマンドのパスを解決する

**Raises**: 明示的な `raise` はなく、条件不成立時は `false` を返す

### `arrange(ost) -> Hash`

`@global_hash` の各キーについて、`ost` の対応する値が `nil` または空白のみの場合に `@global_hash` の値で埋める。

### `tsv_path -> Pathname`

`@ost.tsv_path_index` に対応する `tsv_path_array` の要素を `Pathname` にして返す。

### `make_arg` / `tecspath` / `tecsgen_cmd_path` / `global_yaml_fname` / `test_case_dir` / `tecsgen_cmd` / `target_cmd_1` / `target_cmd_2` / `output_dir` -> Object

`@ost` の対応する値を返す単純なアクセサ群。

### `top_dir -> String`

`@ost.top_dir` を文字列で返す。

**Raises**: `MkspecAppError` — `@ost.top_dir` が空文字列の場合

### `get_key_of_global_yaml_fname` / `get_key_of_tecsgen_cmd` / `get_key_of_tecsgen_cmd_path` / `get_key_of_tecspath` / `get_key_of_tecspath_cmd_path` / `get_key_of_original_output_dir` / `get_key_of_target_cmd_1` / `get_key_of_target_cmd_2` / `get_key_of_test_case_dir` / `get_key_of_top_dir` -> String`

対応するクラス定数（`*_KEY`）をそのまま返すアクセサ群。ハッシュキー名の直書きを避けるために用いる。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Util.load_info` / `extract_in_yaml_file` / `not_empty_hash?` / `not_empty_string?` / `get_path` | YAML読み込みと検証、パス解決 |
| `Loggerxcm` | デバッグログ出力 |
| `OpenStruct` | `@ost` の実装 |

---

## 設計上の注意

- `initialize` や `init_for_ost` は検証失敗時に `false` を返す、または黙って `return` するだけで、呼び出し元（`Mkscript#setup_globalconfig`）はこの戻り値を検証しておらず、失敗が実質的に伝播しない。
- `init_for_ost` 内で `Logger.debug("globalconfig.rb 6")` / `Logger.debug("globalconfig.rb 7")` と、標準Rubyの `Logger` クラス（未定義の裸の定数参照）を呼び出している箇所がある。フレームワーク内の他の全箇所は `Loggerxcm.debug` を使っており、これはタイプミスと思われる。到達すると `NameError` になる可能性がある。
- `arrange` メソッドはクラス内外のどこからも呼び出されておらず、デッドコードの可能性がある。
