# 外部仕様書 — `Util` クラス

**完全修飾名**: `Mkspec::Util`
**種別**: 通常クラス（ユーティリティ／全メソッドがクラスメソッド）

本書は `docs/spec/internal/mkspec/util.md` の内部仕様書と `lib/mkspec/util.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

ファイル・ディレクトリ操作、YAML読み込みとERuby変数展開、文字列/ハッシュ/配列の検証など、Mkspecフレームワーク全体で使われる横断的なユーティリティ関数群を提供するクラス。全メソッドはクラスメソッド（`Util.xxx`）として提供され、インスタンス化は想定されていない。責務外の事項として、フレームワーク固有のビジネスロジック（spec構造の構築等）は本クラスの範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「汎用ユーティリティ」を表す。
- 必須責務: 各クラスから共通して呼び出される、副作用の少ない補助関数群を提供すること。
- 基底クラス: なし。
- 依存クラス: `Loggerxcm`（ログ出力）、`Erubis::Eruby`（ERuby展開）、`YAML`（YAML処理、いずれも外部ライブラリ）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Loggerxcm` | 参照 | 各メソッド内でのデバッグ・エラーログ出力 |
| `Mkspec::MkspecAppError` | 参照 | 検証失敗時の例外送出 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| （クラス内部状態） `@filex_group` | クラスインスタンス変数 | Struct | `Struct.new(:data_dir, :output_dir, :log_dir, :top_dir_yaml, :resolved_top_dir_yaml, :specific_yaml, :global_yaml)` | `adjust_dirs_and_files`の戻り値の型 | 外部から直接変更不可 |
| （クラス内部状態） `@filex` | クラスインスタンス変数 | Struct | `Struct.new(:file_name, :full_path, :pathname)` | 個々のファイル/ディレクトリ情報を表す型 | 外部から直接変更不可 |

上記2件は通常の「クラス定数」ではなく`Util`自身のクラスインスタンス変数として定義されている（詳細は内部仕様書の設計上の注意を参照）。外部からは各メソッドの戻り値の型としてのみ観測できる。

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `load_info` | クラス | YAMLファイルを読み込みハッシュとPathnameを返す |
| `puts_valid_str` | クラス | 空でない文字列のみ`puts`する |
| `adjust_dirs_and_files` | クラス | 環境変数からディレクトリ/ファイル情報一式を構築する |
| `adjust_dirs` | クラス | 環境変数からディレクトリパスを解決する |
| `adjust_files` | クラス | 環境変数からファイルパスを解決する |
| `make_hash_from_files` | クラス | 優先順位付きでYAMLファイルをハッシュ化する |
| `get_path` | クラス | 親ディレクトリ配下のコマンドパスを解決する |
| `make_spec_filename` | クラス | spec出力ファイル名を生成する |
| `get_file_content` | クラス | コメント除去済みのファイル内容を文字列で返す |
| `get_file_content_lines` | クラス | コメント除去済みのファイル内容を行配列で返す |
| `adjust_hash` | クラス | ハッシュの各値をERuby展開しながら調整する |
| `extract_with_eruby` | クラス | ERubyテンプレートをハッシュで展開する |
| `tag_analyze_for_string` | クラス | 1行からERubyタグを抽出する |
| `tag_analyze` | クラス | 複数行からERubyタグを抽出する |
| `tag_analyze_for_contents` | クラス | 改行区切り文字列からERubyタグを抽出する |
| `extract_in_yaml` | クラス | YAML文字列を読み込みERuby展開・再読込する |
| `extract_in_yaml_file` | クラス | YAMLファイルを読み込み`extract_in_yaml`で処理する |
| `check_numeric` | クラス | 配列要素が数値らしいかを判定する |
| `numeric?` | クラス | 値が数値らしいかを判定する |
| `not_empty_string?` | クラス | 非空文字列かどうかを判定する |
| `nil_or_not_empty_string?` | クラス | `nil`または非空文字列かどうかを判定する |
| `not_empty_hash?` | クラス | 非空ハッシュかどうかを判定する |
| `analyze` | クラス | インデント付きERubyタグを解析する |
| `valid_hash_instance?` | クラス | `Hash`のインスタンスかどうかを判定する |
| `valid_hash?` | クラス | ハッシュの特定キーの型を検証する |
| `validate_hash` | クラス | ネストしたハッシュの特定キーの型を再帰的に検証する |
| `valid_array?` | クラス | `Array`のインスタンスかどうかを判定する |
| `valid_pathname?` | クラス | パスが実在するかを判定する |
| `valid_instance?` | クラス | 複数クラスのいずれかのインスタンスかを判定する |
| `make_arg_of_add_test_case_of_testgroup` | クラス | テストケース追加用の`Struct`クラスを生成する |
| その他（`check_var`/`check_filex`/`validate_path`/`validate_filex`/`adjust_hash_sub`/`dump_var`） | クラス | デバッグ・検証用の補助メソッド |

## 6. 公開メソッド仕様

### 6.1 `extract_with_eruby(content, hash = {})`

- **種別**: クラスメソッド
- **前提条件**: `content`が非空文字列、`hash`が`Hash`であること
- **引数**: `content`（String） — ERubyテンプレート文字列、`hash`（Hash, 省略可） — 展開に使う変数
- **戻り値**: 展開後の文字列（String）
- **処理**: `Erubis::Eruby.new(content).result(hash)`を呼び出す
- **例外・エラー**: `MkspecAppError` — `content`が空文字列の場合、または`hash`が`Hash`でない場合

### 6.2 `extract_in_yaml(yaml_str, hash = nil)`

- **種別**: クラスメソッド
- **前提条件**: なし
- **引数**: `yaml_str`（String） — YAML文字列、`hash`（Hash, 省略可） — マージする追加変数
- **戻り値**: YAML読み込み結果（Object、失敗時は空Hash）
- **処理**:
  1. `yaml_str`が空でないことを確認する
  2. `YAML.safe_load`で`yaml_hash`を得る（配列なら先頭要素を採用）
  3. `hash`と`yaml_hash`をマージし`adjust_hash`で調整する
  4. 調整済みハッシュで`yaml_str`自体をERuby展開する
  5. 展開結果を`YAML.safe_load`で読み込み直して返す
- **状態変化・副作用**: なし
- **例外・エラー**: 内部で発生した例外は`Loggerxcm.fatal`でログ記録した上で空Hashを返す（例外を外部に伝播させない設計）

### 6.3 `extract_in_yaml_file(yaml_file_path, hashx = nil)`

- **種別**: クラスメソッド
- **引数**: `yaml_file_path`（String） — YAMLファイルパス、`hashx`（Hash, 省略可）
- **戻り値**: `Hash`（ファイル不在・失敗時は空Hash）
- **処理**: ファイルを読み込み`extract_in_yaml`に処理を委譲する

### 6.4 `adjust_dirs_and_files()`

- **種別**: クラスメソッド
- **戻り値**: `@filex_group`型の`Struct`インスタンス
- **処理**: `adjust_dirs`と`adjust_files`の結果をまとめる

### 6.5 `adjust_dirs()`

- **種別**: クラスメソッド
- **戻り値**: `Array<Struct>`（`@filex`型3件: `MKSPEC_DATA_DIR`/`MKSPEC_OUTPUT_DIR`/`MKSPEC_LOG_DIR`）
- **処理**: 各環境変数を読み取り、未設定時はデフォルト値（`./test_data`等）にフォールバックする

### 6.6 `adjust_files()`

- **種別**: クラスメソッド
- **戻り値**: `Array<Struct>`（`@filex`型4件: `MKSPEC_TOP_DIR_YAML_FNAME`/`MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME`/`MKSPEC_SPECIFIC_YAML_FNAME`/`MKSPEC_GLOBAL_YAML_FNAME`）
- **処理**: `adjust_dirs`と同様の解決を環境変数のファイルパスについて行う

### 6.7 `get_path(parent_dir_pn, dir, cmd_1, cmd_2)`

- **種別**: クラスメソッド
- **引数**: `parent_dir_pn`（Pathname）、`dir`（String）、`cmd_1`/`cmd_2`（String, nil可）
- **戻り値**: `[Pathname, Pathname, Pathname]`（`dir`の実パス、`cmd_1`/`cmd_2`それぞれの実パスまたは`nil`）
- **処理**: `parent_dir_pn/dir`が実在すれば配下の`cmd_1`/`cmd_2`の実在を確認して返す。実在しなければ`[pn_0, nil, nil]`を返す

### 6.8 `not_empty_string?(str)` / `nil_or_not_empty_string?(str)` / `not_empty_hash?(hash)`

- **種別**: クラスメソッド
- **引数**: 検証対象の値
- **戻り値**: `[Boolean, Integer]`のタプル（真偽と、どの分岐で判定されたかを示す内部コード）
- **処理**: 型・空判定を行う（詳細は内部仕様書参照）

### 6.9 `validate_hash(hash, key, klass)`

- **種別**: クラスメソッド
- **引数**: `hash`（Hash）、`key`（Object）、`klass`（Class）
- **戻り値**: Boolean
- **処理**: `hash`を再帰的に走査し、`key`が見つかればその値が`klass`のインスタンスかを判定する。ネストした`Hash`についても再帰する

### 6.10 `numeric?(lookahead)`

- **種別**: クラスメソッド
- **引数**: `lookahead`（String/Integer/その他）
- **戻り値**: Boolean
- **処理**: `String`なら`.`を含めば`false`、空白文字を含まなければ`false`、含めば整数化し非負なら`true`。`Integer`なら非負判定。それ以外は`false`
- **設計上の注意**: 空白文字判定に使う正規表現に既知の不具合がある（内部仕様書参照）。呼び出し側が期待する「空白を含む数値らしい文字列」の判定として機能しない場合がある

その他のメソッド（`load_info`/`puts_valid_str`/`check_var`/`check_filex`/`validate_path`/`validate_filex`/`make_spec_filename`/`get_file_content`/`get_file_content_lines`/`adjust_hash`/`adjust_hash_sub`/`tag_analyze_for_string`/`tag_analyze`/`tag_analyze_for_contents`/`check_numeric`/`dump_var`/`analyze`/`valid_hash_instance?`/`valid_hash?`/`valid_array?`/`valid_pathname?`/`valid_instance?`/`make_arg_of_add_test_case_of_testgroup`）については、内部仕様書（[util.md](../../internal/mkspec/util.md)）の記載どおりであり、公開インターフェースとしての契約（引数・戻り値の型）に外部仕様との差異はない。

## 7. 入出力・永続化

- **入力ファイル**: `load_info`/`extract_in_yaml_file`が読み込む任意のYAMLファイル、`get_file_content`/`get_file_content_lines`が読み込む任意のテキストファイル
- **環境変数**: `adjust_dirs`/`adjust_files`が参照する `MKSPEC_DATA_DIR`・`MKSPEC_OUTPUT_DIR`・`MKSPEC_LOG_DIR`・`MKSPEC_TOP_DIR_YAML_FNAME`・`MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME`・`MKSPEC_SPECIFIC_YAML_FNAME`・`MKSPEC_GLOBAL_YAML_FNAME`（AGENTS.md「必要な環境変数」参照）

## 10. エラー処理・終了コード

`Util`のメソッドは原則として例外を握りつぶし空値（`{}`/`false`等）を返す設計だが、`extract_with_eruby`のみ検証失敗時に`MkspecAppError`を送出する。本例外がどこで捕捉されるかは呼び出し元クラスに依存する。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `extract_with_eruby`が`MkspecAppError`を送出し、`create_files`（`begin`の内側）経由でItem/Root連鎖内から呼ばれる | `bin/mkspec`の`rescue Mkspec::MkspecAppError`で捕捉 | 24（`CANNOT_MAKE_SPEC_FILE`、経路依存） |
| `extract_in_yaml`/`extract_in_yaml_file`内部での例外 | 外部に伝播せず空Hashを返す | コマンド自体は異常終了しない |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/util.rb` の `Mkspec::Util` |
