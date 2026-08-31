# Util — クラス内部仕様書

**ファイル**: `lib/mkspec/util.rb`
**継承**: なし

## 概要

ファイル・ディレクトリ操作、YAML読み込みとERuby変数展開、文字列/ハッシュ/配列の検証など、Mkspecフレームワーク全体で使われる横断的なユーティリティ関数群を提供するクラス。全メソッドは`class << self`によりクラスメソッド（`Util.xxx`）として定義される。

---

## クラス定数（実体はクラスインスタンス変数）

| 変数名 | 値/型 | 用途 |
|--------|-------|------|
| `@filex_group` | `Struct.new(:data_dir, :output_dir, :log_dir, :top_dir_yaml, :resolved_top_dir_yaml, :specific_yaml, :global_yaml)` | `adjust_dirs_and_files`の戻り値の型 |
| `@filex` | `Struct.new(:file_name, :full_path, :pathname)` | 個々のファイル/ディレクトリ情報を表す型 |
| `@re` | `Regexp.new("<%=([^%]+)%>")` | ERubyの`<%= %>`タグ抽出用正規表現 |
| `@re2` | `Regexp.new("^(\s*)<%=(.+)%>")` | インデント付きERubyタグ抽出用正規表現 |

---

## メソッド

すべて `class << self` によるクラスメソッドとして定義される。

### `load_info(path) -> [Hash, Pathname]`

YAMLファイルが存在すればその内容を、存在しなければ空ハッシュを、`Pathname`とともに返す。

### `puts_valid_str(str) -> nil`

`str`が`nil`でなく、空白・改行を除去した結果が空でなければ`puts`する。

### `check_var(place, varx, varxname) -> Integer`

変数が`nil`かどうかをログに出し、`nil`だった件数を返す。

### `check_filex(place, var, varname) -> nil`

`var.pathname`をログ出力する。

### `validate_path(place, var, varname) -> Integer`

`var`が`nil`ならfatalログを出し、件数を返す。

### `validate_filex(place, varx, varnamex) -> Integer`

`varx`が`nil`、または`varx.pathname`が`Pathname`のインスタンスでない場合にfatalログを出し件数を返す。

### `adjust_dirs_and_files -> Struct`

`adjust_dirs`と`adjust_files`の結果をまとめて`@filex_group`インスタンスとして返す。

### `adjust_dirs -> Array<Struct>`

環境変数 `MKSPEC_DATA_DIR` / `MKSPEC_OUTPUT_DIR` / `MKSPEC_LOG_DIR` を読み取り、デフォルト値（`./test_data`等）とのフォールバックを行いつつ、それぞれ`@filex`（名前・パス文字列・展開済みPathname）の配列として返す。

### `adjust_files -> Array<Struct>`

環境変数 `MKSPEC_TOP_DIR_YAML_FNAME` / `MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME` / `MKSPEC_SPECIFIC_YAML_FNAME` / `MKSPEC_GLOBAL_YAML_FNAME` について、`adjust_dirs`と同様の解決を行う。

### `make_hash_from_files(path_filex, resolved_filex) -> Hash`

`resolved_filex`のパスが存在すればそれを、なければ`path_filex`のパスを使ってYAMLをハッシュ化する。どちらも無効なら空ハッシュを返す。

### `get_path(parent_dir_pn, dir, cmd_1, cmd_2) -> [Pathname, Pathname, Pathname]`

`parent_dir_pn/dir`が実在すれば、その配下の`cmd_1`/`cmd_2`（存在すれば）の実パスを合わせて返す。

### `make_spec_filename(name) -> String`

`"#{name}_spec.rb"`を返す。

### `get_file_content(file_path) -> String`

`get_file_content_lines`の結果を改行で連結して返す。

### `get_file_content_lines(file_path) -> Array<String>`

ファイルを1行ずつ読み込み、`#`始まりのコメント行を除いた行配列を返す。

### `adjust_hash_sub(hash, key_0, value_0, hashx) -> nil`

`value_0`がString/Integer/Array/Hashでなければ何もしない。`value_0`中の`<%= tag %>`を解析し、`hash`内の該当タグの値を再帰的にERuby展開しながら`hashx`（結果ハッシュ）に書き込む。単純な値の場合はそのまま`hashx[key_0] = value_0`とする。

処理フロー:
  1. `value_0`の型を検証する（対象外なら終了）
  2. `value_0`中のタグ（`<%= %>`）を抽出する
  3. タグが無ければ`hashx[key_0] = value_0`として終了する
  4. タグがあれば、各タグについて`hash`内の参照先を再帰的にたどりながらERuby展開し、`hashx`に登録していく
  5. 最終的に`hashx[key_0]`に展開結果を設定する

### `adjust_hash(hash) -> Hash`

`hash`の各キー・値について`adjust_hash_sub`を適用し、変換済みの新しいハッシュを返す。

### `extract_with_eruby(content, hash = {}) -> String`

Erubisを用いて`content`中の`<%= %>`/`<% %>`を`hash`の値で展開した結果を返す。

**Raises**: `MkspecAppError` — `content`が空文字列、または`hash`が`Hash`でない場合

### `tag_analyze_for_string(line) -> Array<String>`

1行の文字列から`<%= tag %>`形式のタグを全て抽出して返す。

### `tag_analyze(lines) -> Array<String>`

複数行の配列から`tag_analyze_for_string`を適用し、結果をフラットな配列にまとめる。

### `tag_analyze_for_contents(contents) -> Array<String>`

改行区切りの文字列を行に分割し、`tag_analyze_for_string`を適用してタグを集める。

### `extract_in_yaml(yaml_str, hash = nil) -> Object`

YAML文字列を安全に読み込み、`hash`とマージ・調整（`adjust_hash`）した上でERuby展開し、再度YAMLとして読み込んだ結果を返す。

処理フロー:
  1. `yaml_str`が空でないことを確認する
  2. `YAML.safe_load`で`yaml_hash`を得る（配列なら先頭要素を採用）
  3. `hash`と`yaml_hash`をマージして`adjust_hash`で調整する
  4. 調整済みハッシュを使い`yaml_str`自体をERuby展開する
  5. 展開結果を`YAML.safe_load`で読み込み直して返す

**Returns**: 読み込んだYAMLの内容（空/失敗時は空ハッシュ）

### `extract_in_yaml_file(yaml_file_path, hashx = nil) -> Hash`

YAMLファイルを読み込み、`extract_in_yaml`で処理した結果を返す。ファイルが存在しない場合や結果が空の場合は空ハッシュを返す。

### `check_numeric(tmp, num) -> Boolean`

`num`自体が数値らしく、かつ`tmp[num]`が存在してそれも数値らしい場合に`true`を返す。

### `numeric?(lookahead) -> Boolean`

`lookahead`が`String`の場合、`.`を含めば`false`、空白文字を含まなければ`false`、含めば整数化して非負なら`true`を返す。`Integer`の場合は非負なら`true`。それ以外は`false`。

### `nil_or_not_empty_string?(str) -> [Boolean, Integer]`

`str`が`nil`なら`[true, 1]`、`String`でなければ`[false, 2]`、空/空白のみなら`[false, 3]`、それ以外は`[true, 4]`を返す。

### `not_empty_string?(str) -> [Boolean, Integer]`

`str`が存在せず、または`String`でなく、または空/空白のみなら`false`系のタプルを、それ以外は`[true, 4]`を返す。

### `not_empty_hash?(hash) -> [Boolean, Integer]`

`hash`が存在せず、または`Hash`でなく、または空なら`false`系のタプルを、それ以外は`[true, 4]`を返す。

### `dump_var(name, value) -> nil`

変数名と値をデバッグログに出力する。

### `analyze(content_lines) -> Hash`

各行についてインデント付きタグ（`@re2`）にマッチすれば、タグ本体をキー、インデント幅を値とするハッシュを構築する。

### `valid_hash_instance?(hash) -> Boolean`

`hash`が`Hash`のインスタンスかどうかを返す。

### `valid_hash?(hash, key, klass) -> Boolean`

`hash[key]`が存在し、かつ`klass`のインスタンスでない場合のみ`false`を返す（存在しない場合や型が一致する場合は`true`）。

### `validate_hash(hash, key, klass) -> Boolean`

`hash`を再帰的に走査し、`key`が見つかればその値が`klass`のインスタンスかどうかを判定する。ネストした`Hash`の値についても再帰的に検証する。

### `valid_array?(item) -> Boolean`

`item`が`Array`のインスタンスかどうかを返す。

### `valid_pathname?(pna) -> Boolean`

`pna`が存在する（`exist?`）かどうかを返す。

### `valid_instance?(item, *klasses) -> Boolean`

`item`が`klasses`のいずれかのインスタンスかどうかを返す。

### `make_arg_of_add_test_case_of_testgroup -> Class`

`testgroup`/`tcase`/各種テスト条件・メッセージ・タグ・`extra`をキーワード引数として持つ`Struct`クラスを生成して返す。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Loggerxcm` | ログ出力 |
| `Erubis::Eruby` | ERuby展開 |
| `YAML` | YAML読み込み |
| `Mkspec::MkspecAppError` | 検証失敗時の例外 |

---

## 設計上の注意

- `validate_filex`は`varx.nil?`の分岐内で`varname`という未定義のローカル変数を参照している（パラメータ名は`varnamex`）。到達すると`NameError`になる。
- `numeric?`のString分岐は`/[:blank:]/`という正規表現を使っているが、これは角括弧`[]`内にPOSIXブラケット式`[:blank:]`をさらに入れ子にする（`/[[:blank:]]/`）べきところ、文字クラスとして`:`,`b`,`l`,`a`,`n`,`k`の各文字そのものにマッチする式になっている。意図した「空白文字を含むか」の判定になっていない。
- `adjust_hash_sub`の内部で、外側の`each`ブロック引数`tag_x`を内側のループ内で再代入（`tag_x = tag_y`）しており、Rubyの挙動として合法だが、ブロック引数を可変な作業変数として使い回す書き方になっており可読性が低い。
- `@filex_group`/`@filex`/`@re`/`@re2`はクラス定数（`CONST_NAME`形式）ではなく、クラス`Util`自体のインスタンス変数（`@`接頭辞）として定義されている。実質的に不変の設定値であるにもかかわらず、通常の`Struct`/`Regexp`定数と異なる書き方になっている。
