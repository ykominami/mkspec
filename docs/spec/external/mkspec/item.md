# 外部仕様書 — `Item` クラス

**完全修飾名**: `Mkspec::Item`
**種別**: 通常クラス（再帰的コンテンツ単位）

本書は `docs/spec/internal/mkspec/item.md` の内部仕様書と `lib/mkspec/item.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

YAMLデータ（`yaml_path`）とERubyテンプレート（`content_path`）を合成し、テンプレート中の`<%= tag %>`を解析して再帰的に子`Item`を生成し、最終的にERuby展開したコンテンツ文字列を返す、mkspecのspec文字列組み立ての中核クラス。責務外の事項として、トップレベルのYAML読み込みと`Item`階層全体の起動（`Root`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「テンプレートとデータの合成単位」を表す。
- 必須責務: 1つのテンプレート断片について、タグ解析・子`Item`生成・ERuby展開を行うこと。
- 基底クラス: なし。
- 依存クラス: `Item`自身（再帰）、`Config`（パス解決）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Item` | 参照（自己再帰） | タグに対応する子`Item`を生成する |
| `Config` | 参照 | `archive_dir_pn`/`make_path_under_template_and_data_dir` |
| `Util` | 参照 | ハッシュ検証・YAML抽出・ERuby展開 |
| `State` | 参照 | 子`Item`生成後の状態確認（`STATE.success?`） |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `INDENT_UNIT_SIZE` | クラス定数 | Integer | 2 | インデント1レベルあたりの空白数 | 不可 |
| `content_lines` | インスタンス属性（読み取り専用） | Array<String> | - | テンプレート本体の行配列 | 不可 |
| `name` | インスタンス属性（読み取り専用） | String | - | このItemのタグ名 | 不可 |
| `outer_hash` | インスタンス属性（読み取り専用） | Hash | - | 親から渡されたハッシュ | 不可 |
| `tag_table` | インスタンス属性（読み取り専用） | Hash | - | `<%= tag %>`の出現位置とインデント幅 | 不可 |
| `local_hash` | インスタンス属性（読み取り専用） | Hash | - | データYAMLから読み込んだ内容 | 不可 |
| `extract_count` | インスタンス属性（読み取り専用） | Integer | 常に0 | 未使用（設計上の注意参照） | 不可 |
| `state` | インスタンス属性（読み取り専用） | 常に`nil` | - | 実装上未設定のまま公開される属性（§10参照） | 不可 |
| `content_path` | インスタンス属性（読み取り専用） | 常に`nil` | - | 実装上未設定のまま公開される属性 | 不可 |
| `yaml_path` | インスタンス属性（読み取り専用） | 常に`nil` | - | 実装上未設定のまま公開される属性 | 不可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | YAML・コンテンツファイルのパスを解決し初期化する |
| `result` | インスタンス | コンテンツをERuby展開した結果を返す |

## 6. 公開メソッド仕様

### 6.1 `initialize(indent_level, extra_indent, name, outer_hash, content_path, yaml_path, config)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `outer_hash`が`"top_dir"`キーを`String`型で持つこと
- **引数**: `indent_level`（Integer） — ネストの深さ、`extra_indent`（Integer） — 追加インデント、`name`（String） — タグ名、`outer_hash`（Hash） — 親のハッシュ、`content_path`（String） — テンプレートファイルの相対パス、`yaml_path`（String, nil可） — データYAMLのパス、`config`（Config）
- **戻り値**: 生成された`Item`インスタンス
- **処理**:
  1. `outer_hash`を検証する
  2. `content_path`を`config.archive_dir_pn`基準の絶対パスに変換する
  3. YAML・コンテンツのパスをそれぞれ実在パスへ解決する
  4. コンテンツ本体を読み込みタグを解析、タグに対応する子`Item`を再帰的に生成してハッシュにマージする
- **状態変化・副作用**: なし（自インスタンスの内部状態構築のみ）
- **例外・エラー**: `MkspecDebugError` — `outer_hash`の検証失敗時、コンテンツパスが解決できない場合。`MkspecAppError` — YAML/コンテンツの検証失敗時

### 6.2 `result()`

- **種別**: インスタンスメソッド
- **前提条件**: コンテンツファイルが存在すること
- **引数**: なし
- **戻り値**: `String`（ERuby展開後のコンテンツ）
- **処理**: `content_lines`を結合し`Util.extract_with_eruby`でERuby展開する
- **例外・エラー**: `MkspecAppError` — コンテンツファイルが存在しない場合

## 7. 入出力・永続化

- **入力ファイル**: テンプレートファイル（`content_path`が指す`content.txt`等）、データYAMLファイル（`yaml_path`）

## 9. 不変条件・状態遷移

- `local_hash`が空でない場合はそれを、空の場合は`outer_hash`を実際の展開用ハッシュとして採用する（データYAML優先、無ければ親から継承）。
- 子`Item`の生成は`tag_table`に列挙されたタグの数だけ再帰的に行われ、末端（子タグを持たないテンプレート）に達すると再帰が止まる。

## 10. エラー処理・終了コード

`Item`は`Root#extract_in_hash_with_setting_hash`/`#make_item`から呼び出され、これは`Mkscript#make_spec_file`内の`begin...rescue StandardError`（`create_files`経由、CLIの`begin`の**内側**）で保護されている。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `initialize`/`prepare`/`result`が`MkspecDebugError`または`MkspecAppError`を送出 | `Mkscript#make_spec_file`内の`rescue StandardError`で捕捉され`STATE`が`CANNOT_MAKE_SPEC_FILE`に変更された後、`MkspecAppError`として再送出され`bin/mkspec`の`rescue Mkspec::MkspecAppError`で捕捉される | 24（`CANNOT_MAKE_SPEC_FILE`） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/item.rb` の `Mkspec::Item` |
