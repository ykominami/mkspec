# Item — クラス内部仕様書

**ファイル**: `lib/mkspec/item.rb`
**継承**: なし

## 概要

YAMLデータ（`yaml_path`）とERubyテンプレート（`content_path`）を合成し、テンプレート中の `<%= tag %>` を解析して再帰的に子 `Item` を生成し、最終的にERuby展開したコンテンツ文字列を返す、mkspecのspec文字列組み立ての中核クラス。

---

## クラス定数

| 定数名 | 値 | 説明 |
|--------|----|------|
| `INDENT_UNIT_SIZE` | 2 | インデント1レベルあたりの空白数（`add_indent`で使用） |

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `state` | 常に `nil` | `attr_reader`で公開されるが本ファイル内で代入されていない |
| `content_lines` | Array<String> | `@content_pn` から読み込んだテンプレート本体の行配列 |
| `content_path` | 常に `nil` | `attr_reader`で公開されるが本ファイル内で代入されていない（実体は`@content_pn`） |
| `name` | String | このItemのタグ名 |
| `outer_hash` | Hash | 親から渡されたハッシュ |
| `tag_table` | Hash | `<%= tag %>` の出現位置とインデント幅を解析した結果 |
| `extract_count` | Integer | 初期化時に0で固定され、以後更新されない |
| `local_hash` | Hash | `@yaml_pn` から読み込んだYAMLの内容 |
| `yaml_path` | 常に `nil` | `attr_reader`で公開されるが本ファイル内で代入されていない（実体は`@yaml_pn`） |

---

## メソッド

### `initialize(indent_level, extra_indent, name, outer_hash, content_path, yaml_path, config) -> Item`

YAML・コンテンツファイルのパスを解決し、`prepare` を呼び出す。

処理フロー:
  1. `outer_hash` に `"top_dir"` キーが `String` 型で存在するか検証する（不正なら `MkspecDebugError`）
  2. `content_path` を `@config.archive_dir_pn` 基準の絶対パスに変換する
  3. `yaml_path`・変換後の`content_path`をそれぞれ `ensure_path` で実在パスに解決する
  4. コンテンツパスが解決できなければ `MkspecDebugError` を送出する
  5. `prepare` を呼び出しコンテンツとタグの解析を行う

**Args**: `indent_level` — ネストの深さ、`extra_indent` — 追加インデント、`name` — タグ名、`outer_hash` — 親のハッシュ、`content_path` — テンプレートファイルの相対パス、`yaml_path` — データYAMLのパス、`config` — `Config` インスタンス
**Raises**: `Mkspec::MkspecDebugError` — `outer_hash` の検証失敗時、コンテンツパスが解決できない場合

### `ensure_path(path) -> [Pathname, Integer]`

文字列 `path` を実在パスへ解決する。

**Returns**: `[Pathname, kind]`。`kind` は 1（`path`自体が実在）、2（テンプレート/データディレクトリ配下で解決）、3（いずれにも実在しない）、4（`path`が空文字列）のいずれか

### `prepare -> Hash`

YAMLデータとコンテンツ行を読み込み、タグテーブルを解析し、子 `Item` を構築してハッシュにマージする。

処理フロー:
  1. `@yaml_pn` が存在すれば `@local_hash` をYAMLから抽出する
  2. `@local_hash` を検証する（`"top_dir"` キーが `String`）
  3. `@content_pn` からコンテンツ行を読み込む
  4. コンテンツ行を解析してタグテーブル（`@tag_table`）を作る
  5. `@local_hash` が空でなければ `@local_hash`、空なら `@outer_hash` を `@hash` として採用する
  6. タグテーブルを元に子 `Item` を作成し、各子の `result` を `@hash` にマージする

**Raises**: `Mkspec::MkspecDebugError` / `MkspecAppError` — 各種検証失敗時

### `check_kind_of_hash -> nil`

デバッグ用に `@hash` が `local_hash` か `outer_hash` かをログ出力する。

### `result -> String`

コンテンツ行を結合しERubyテンプレートとして展開した結果を返す。

**Raises**: `MkspecAppError` — `@content_pn` が存在しない場合

### `add_indent(hash) -> nil`

`hash` の各値に対しインデントを付与する（詳細は設計上の注意を参照）。

### `make_children(tag_table, hash) -> Hash`

`tag_table` の各タグについて `hash[tag]` の型に応じて子 `Item` を生成する（`Hash` なら新規 `Item`、`String` ならログのみ、それ以外は何もしない）。

**Returns**: `Hash`（タグ名 => `Item`）

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Util` | ハッシュ検証・YAML抽出・ERuby展開 |
| `Loggerxcm` | デバッグログ出力 |
| `Config` | `archive_dir_pn` / `make_path_under_template_and_data_dir` |
| `Mkspec::MkspecDebugError` / `MkspecAppError` | 検証失敗時の例外 |
| `STATE` | 子`Item`生成後の状態確認 |

---

## 設計上の注意

- `attr_reader :state`、`:content_path`、`:yaml_path` は対応するインスタンス変数（`@state`・`@content_path`・`@yaml_path`）が本ファイル内で一切代入されておらず、常に `nil` を返す。
- `check_kind_of_hash` は `@logcal_hash` という誤字のインスタンス変数（未定義のため `nil`）と `@hash` を比較しており、意図した比較（`@local_hash`）になっていない。常に `"outer_hash"` 側の分岐に入る。
- `add_indent` は `hash.keys do |key| ... end` という記述をしているが、`Hash#keys` はブロックを取らないメソッドであるため渡したブロックは実行されない。仮に実行されたとしても内部で `l.size.positiv?`（正しくは `positive?`）という存在しないメソッドを呼んでおり `NoMethodError` になる。さらにこのメソッドはクラス内のどこからも呼び出されておらず、デッドコードの可能性が高い。
