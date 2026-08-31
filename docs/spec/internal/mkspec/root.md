# Root — クラス内部仕様書

**ファイル**: `lib/mkspec/root.rb`
**継承**: なし

## 概要

トップレベルのデータYAMLを読み込み、`Item` の階層を再帰的に構築してRSpec仕様ファイルの文字列を生成する、`Mkscript#make_spec_file` からのエントリーポイントクラス。

---

## インスタンス変数

| 変数名 | 型 | 説明 |
|--------|----|------|
| `@setting_hash` | Hash | トップレベルのデータYAMLの内容 |
| `@content_path` | String | `@setting_hash['path']`（トップレベルのテンプレートパス） |
| `@config` | Config | `Config` インスタンス |
| `@content_pn` | Pathname | `@content_path` をテンプレート/データディレクトリ基準で解決したパス |
| `@level` | Integer | ネストレベル（初期値1） |

---

## メソッド

### `initialize(yml_fname, config) -> Root`

データYAMLを読み込み、トップレベルのテンプレートパスを解決する。

処理フロー:
  1. `yml_fname` が実在すればそれを、なければ `config.make_path_under_misc_dir` で解決したパスを使う
  2. パスが存在しなければ `MkspecDebugError` を送出する
  3. YAMLから `@setting_hash` を抽出し、`"top_dir"` キーの型を検証する
  4. `@setting_hash['path']` を `@content_path` として取得する（なければ `MkspecDebugError`）
  5. `@content_pn` をテンプレート/データディレクトリ基準で解決し、`@level` を1に設定する

**Args**: `yml_fname` — データYAMLファイルのパス、`config` — `Config` インスタンス
**Raises**: `Mkspec::MkspecDebugError` — YAMLファイルが見つからない場合、検証失敗時、`path` が取得できない場合

### `extract_in_hash_with_setting_hash(hash) -> nil`

`@setting_hash` の各エントリについて、値が `Hash` なら `Item` を生成し `result` を `hash` に設定する。それ以外はそのまま `hash` にコピーする（破壊的）。

**Raises**: `Mkspec::MkspecDebugError` — 値が `Hash` かつ `"top_dir"` キー検証に失敗した場合

### `make_item(hash) -> Item`

`extract_in_hash_with_setting_hash` で `hash` を構築した後、それを `outer_hash` とするルート `Item` を生成する。

### `result -> String, nil`

ルート `Item` の `result` を取得し、空でなければERubyとして再展開して返す。

処理フロー:
  1. `make_item` でルート `Item` を構築する
  2. `item.result` でコンテンツ文字列を取得する
  3. 空文字列でなければ `Util.extract_with_eruby` で再度ERuby展開して返す
  4. 空文字列なら `nil` を返す

**Returns**: `String`、または `nil`

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Item` | コンテンツ生成の再帰単位 |
| `Util` | YAML抽出・ハッシュ検証・ERuby展開 |
| `Config` | `make_path_under_misc_dir` / `make_path_under_template_and_data_dir` |
| `Loggerxcm` | デバッグログ出力 |
| `Mkspec::MkspecDebugError` | 検証失敗時の例外 |

---

## 設計上の注意

- `result` で `item.result` の結果を再度 `Util.extract_with_eruby` に通しているが、`Item#result` 内部でも同じ `extract_with_eruby` が既に適用されている。二重にERuby展開する意図がコードから読み取りにくく、`content` に展開しきれなかった `<%= %>` タグが残っている場合のみ意味を持つ処理になっている。
