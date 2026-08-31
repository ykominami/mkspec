# Setting — クラス内部仕様書

**ファイル**: `lib/mkspec/setting.rb`
**継承**: なし

## 概要

1つの `TestScript` に対応する設定を保持し、テンプレートパス・データYAMLパスの決定、RSpecの`describe`/`context`構造をハッシュとして構築し、データYAMLファイルとして出力するクラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `template_path` | Pathname | `attr_reader`。テンプレート本体（`content.txt`）のパス |
| `testscript` | TestScript | `attr_reader`。対応する`TestScript` |
| `data_yaml_path` | Pathname | `attr_reader`。データYAMLの出力先パス |
| `func_name_of_make_arg` | String | `attr_reader`。make引数生成に使う関数名 |
| `lt_id` | Integer | `attr_reader`。テストケースIDの連番カウンタ |
| `@gc` | GlobalConfig | グローバル設定 |
| `@hash` | Hash | データYAMLとして出力するハッシュ |
| `@path_value` | Pathname | `@template_path` の相対パス表現 |

---

## メソッド

### `initialize(global_config, testscript, config, initail_testcase_id) -> Setting`

テンプレート/データYAMLのパスを決定し、初期状態を構築する。

処理フロー:
  1. `global_config` が無ければ何もせず終了する（即 `return`）
  2. `testscript.name` が空文字列なら終了する
  3. `config` が `nil` なら終了する
  4. テンプレート/データディレクトリ配下に `testscript` 名のサブディレクトリを作成し、`content.txt` へのパスを `@template_path` とする
  5. `testscript` 名からデータYAMLパス（`<name>.yml`）を決定する
  6. `gc.make_arg` が空なら終了する（この時点で `@func_name_of_make_arg` / `@lt_id` は未設定のまま）
  7. `@func_name_of_make_arg`、`@lt_id` を設定する

**Args**: `global_config` — `GlobalConfig`、`testscript` — 対応する`TestScript`、`config` — `Config`、`initail_testcase_id` — 開始テストケースID

### `next_testcase_id -> Integer`

`@lt_id` をインクリメントして返す。

### `setup(desc) -> Boolean`

`rspec_describe_head`/`end`/`context_end`等の固定コンテンツと、各`TestGroup`に対応するcontext構造を `@hash` に構築する。

処理フロー:
  1. `path`/`desc` をセットする
  2. `rspec_describe_head`（トップディレクトリ・出力先・対象コマンド等のメタ情報を含む）/`rspec_describe_end`/`rspec_describe_context_end` の各エントリを `@hash` に設定する
  3. `testscript.test_groups` の各グループについて `make_context` → `make_make_arg` → `setup_test_cases` を順に実行し、いずれか失敗すれば `error_count` を加算する

**Args**: `desc` — 説明文字列
**Raises**: `MkspecAppError` — `test_group.name` が空の場合
**Returns**: `error_count.zero?`

### `setup_test_cases(test_group) -> Boolean`

`test_group` 内の各 `TestCase` について `make_make_arg` と `make_context_context` を呼び出しRSpecコンテキストを構築する。

処理フロー:
  1. `test_group_name` を検証する
  2. 各 `test_case` について `func_name`（`test_case.extra` があれば優先）で `make_make_arg` を実行する
  3. `test_case.test_1` が数値なら `MkspecDebugError`
  4. `make_context_context` でコンテキストハッシュを追加する

**Raises**: `MkspecAppError` / `MkspecDebugError`
**Returns**: `error_count.zero?`

### `output_data_yamlfile -> Boolean`

`@hash` をYAML形式で `@data_yaml_path` へ書き出す。

**Raises**: 失敗時に `STATE.change(Mkspec::CANNOT_WRITE_YAML_FILE)` を行った上で、後続の `raise` 文（設計上の注意を参照）に到達する

### `make_context(test_group_name) -> Hash`

RSpecの`context`ブロック用のハッシュエントリを `@hash` に追加する。

**Raises**: `MkspecAppError` — 名前が空、または既に同名キーが存在する場合

### `make_make_arg(content_name, func_name, option_list = []) -> Boolean`

make系コマンドの引数情報を `@hash` に登録する。

**Returns**: `content_name`/`func_name` が空なら `false`、それ以外は `true`（ただし `@hash` への書き込み自体は`ret`の値によらず実行される）

### `make_context_context(test_case_name, test_group, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, func_name) -> Hash`

1つのテストケースに対応する、2つの連番テストケースID（`tc_0`/`tc_1`）付きのRSpecコンテキストを `@hash` に追加する。

**Raises**: `MkspecAppError` — `test_case_name` が空の場合

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `TestScript` / `TestGroup` / `TestCase` | 構造の入力元 |
| `GlobalConfig.get_key_of_*` | ハッシュキー名の解決 |
| `Util` | 文字列検証 |
| `Loggerxcm` | ログ出力 |
| `STATE` | 状態管理 |
| `YAML` | データYAML出力 |

---

## 設計上の注意

- `initialize` 内の複数のガード節はコメントアウトされた `raise` の代わりに `return` のみを行っており、必須データ（`@func_name_of_make_arg` / `@lt_id` 等）が揃わないまま初期化が「成功」した状態になる。後続の `setup` 呼び出し時にこれらが `nil` のままだと予期しないエラーを招きやすい。
- `output_data_yamlfile` 内の `raise Mkspec::MkspecDebugError("setting.rb 8 ", STATE.message_array)` は、`.new` を使わずに例外クラス自体を呼び出しており、`NoMethodError` になる（本来は `raise Mkspec::MkspecDebugError, "..."` または `.new(...)` を渡す必要がある）。
- `make_make_arg` は `content_name`/`func_name` が空でも `false` を返すだけで `@hash[content_name]` への書き込みは無条件に実行されるため、戻り値（失敗）と実際の副作用（ハッシュへの登録）が矛盾している。
