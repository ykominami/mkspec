# 外部仕様書 — `GlobalConfig` クラス

**完全修飾名**: `Mkspec::GlobalConfig`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/globalconfig.md` の内部仕様書と `lib/mkspec/globalconfig.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

`global.yml`と`specific.yml`を読み込みマージして、`OpenStruct`（`ost`）としてフレームワーク全体の設定値を一元管理するクラス。YAMLハッシュのキー名を表す多数の文字列定数（`*_KEY`）を定義し、キー名の直書きを避けるためのアクセサ（`get_key_of_*`）を提供する。責務外の事項として、CLIオプションの解析（`Mkscript`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「フレームワーク全体のグローバル設定」を表す。
- 必須責務: `global.yml`/`specific.yml`のマージ結果を`OpenStruct`として提供すること。
- 基底クラス: なし。
- 依存クラス: `Util`（YAML読込・検証）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `Util` | 参照 | `load_info`/`extract_in_yaml_file`/`not_empty_hash?`/`not_empty_string?`/`get_path` |
| `OpenStruct`（標準ライブラリ） | 合成 | `ost`属性の実装 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `ost` | インスタンス属性 | OpenStruct | `initialize`成功時に構築 | フレームワーク全体の設定値を保持するメイン構造体 | 可（`OpenStruct`のため任意キーの追加・変更が可能） |
| `specific_hash` | インスタンス属性 | Hash | `specific.yml`の内容 | specific.ymlの生データ | 可 |
| `TEST_DIR`・`MISC_DIR`・`OUTPUT_TEMPLATE_AND_DATA_DIR`・`OUTPUT_TEST_CASE_DIR`・`TEST_CASE_ARCHIVE_DIR`・`TEST_ARCHIVE_DIR` 等 | クラス定数 | String | 固定文字列（例: `"test"`, `"misc"`） | ディレクトリ/ファイル名の既定値 | 不可 |
| `*_KEY`（`SPECIFIC_YAML_FNAME_KEY`等、30種類超） | クラス定数 | String | ハッシュキー名の文字列 | YAMLハッシュのキー名を直書きせず参照するための定数 | 不可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | global.yml/specific.ymlを読み込み`ost`を構築する |
| `arrange` | インスタンス | `ost`の未設定値を`@global_hash`の値で埋める |
| `tsv_path` | インスタンス | 現在のTSVパスを返す |
| `make_arg`/`tecspath`/`tecsgen_cmd_path`/`global_yaml_fname`/`test_case_dir`/`tecsgen_cmd`/`target_cmd_1`/`target_cmd_2`/`output_dir` | インスタンス | `ost`の対応する値を返す単純なアクセサ |
| `top_dir` | インスタンス | `ost.top_dir`を検証付きで返す |
| `get_key_of_*`（10種類） | インスタンス | 対応するクラス定数（`*_KEY`）を返す |

## 6. 公開メソッド仕様

### 6.1 `initialize(new_count, init_hash, dirs_and_files, target_cmd_1 = nil, target_cmd_2 = nil)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `dirs_and_files.global_yaml.pathname`が実在すること（実在しない場合は`ost`が構築されないまま初期化が終了する）
- **引数**: `new_count`（Boolean） — `-n`相当のフラグ、`init_hash`（Hash） — CLI由来の初期値、`dirs_and_files`（Struct） — 各種パス情報、`target_cmd_1`/`target_cmd_2`（String, 省略可） — 対象コマンド名
- **戻り値**: 生成された`GlobalConfig`インスタンス（`ost`が未構築の場合もエラーにはならず、呼び出し側が`ost`の状態を確認する必要がある）
- **処理**:
  1. `global.yml`の存在を確認する（なければ処理を打ち切る）
  2. `specific.yml`を読み込む
  3. `global.yml`の内容とマージし`@global_hash`を作る
  4. `@ost`（OpenStruct）を構築する
  5. ログ・データ・出力ディレクトリを`@ost`に設定する
  6. テストルート・出力先等の派生パスを`@ost`に設定する
- **状態変化・副作用**: なし（呼び出し元インスタンスの状態を構築するのみ）
- **例外・エラー**: 明示的な例外は送出しない。検証失敗時は`ost`が未構築のまま初期化を終える

### 6.2 `top_dir()`

- **種別**: インスタンスメソッド
- **前提条件**: `ost.top_dir`が非空文字列であること
- **戻り値**: `String`
- **処理**: `@ost.top_dir.to_s`を返す
- **例外・エラー**: `MkspecAppError` — `ost.top_dir`が空文字列の場合

### 6.3 `tsv_path()`

- **種別**: インスタンスメソッド
- **戻り値**: `Pathname`
- **処理**: `ost.tsv_path_array[ost.tsv_path_index]`を`Pathname`化して返す

### 6.4 `arrange(ost)`

- **種別**: インスタンスメソッド
- **引数**: `ost`（OpenStruct）
- **戻り値**: `Hash`
- **処理**: `@global_hash`の各キーについて、`ost`の対応する値が`nil`または空白のみの場合に埋める
- **設計上の注意**: 本メソッドはフレームワーク内のどこからも呼び出されていない（§10参照）

### 6.5 `get_key_of_global_yaml_fname()` ほか9種類

- **種別**: インスタンスメソッド
- **戻り値**: `String`（対応するクラス定数`*_KEY`をそのまま返す）
- **例外・エラー**: なし

## 7. 入出力・永続化

- **入力ファイル**: `global.yml`（環境変数`MKSPEC_GLOBAL_YAML_FNAME`）、`specific.yml`（環境変数`MKSPEC_SPECIFIC_YAML_FNAME`）
- **出力ディレクトリ**: ログディレクトリ（`ost.log_dir_pn`）を存在しなければ作成する

## 9. 不変条件・状態遷移

- `initialize`の各検証ステップはいずれかが失敗すると以後の処理を行わずに`return`する。そのため`ost`は「完全に構築される」か「部分的にしか構築されない」かのいずれかであり、中間状態の判定手段は`ost`の各フィールドが`nil`かどうかを個別に確認する以外にない。

## 10. エラー処理・終了コード

`GlobalConfig.new`は`Mkscript#setup_globalconfig`（`check_cli_options`経由、CLIの`begin...rescue`の**外側**）から呼び出される。`initialize`自体は失敗時も例外を送出しないため、通常はプロセスを異常終了させない。一方、`top_dir`メソッドは`Setting#setup`から呼び出され、これは`Mkscript#init`経由（同じく`begin`の外側）で実行される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `initialize`内の検証失敗（YAML不在等） | 例外を送出せず`ost`が未構築のまま終了。後続で`ost`の各属性を参照する処理が`NoMethodError`（`nil`に対するメソッド呼び出し）を送出しうる | 経路依存。`begin`の外側で発生すればRuby既定の`1`、内側であれば`STATE`依存 |
| `top_dir`が`MkspecAppError`を送出 | `Setting#setup`経由（`begin`の外側）のため未捕捉、Rubyの未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `init_for_ost`内の`Logger.debug`（誤字）到達 | `NameError`が未捕捉のままプロセス終了 | 1（Ruby既定） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/globalconfig.rb` の `Mkspec::GlobalConfig` |
