# 外部仕様書 — `TestScriptGroup` クラス

**完全修飾名**: `Mkspec::TestScriptGroup`
**種別**: 通常クラス

本書は `docs/spec/internal/mkspec/testscriptgroup.md` の内部仕様書と `lib/mkspec/testscriptgroup.rb` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

TSVファイルを読み込み `TestGroup`/`TestCase` を生成し、上限（`limit`）を超えないよう `TestScript` 単位に分割してまとめるクラス。TSVの各行は「グループ名 / テストケース番号 / 任意の追加パラメータ」の形式を想定する（AGENTS.md「テストデータ形式」参照）。責務外の事項として、生成した`TestScript`群から実際のspecファイルを出力する処理（`Mkscript`/`Setting`/`Templatex`/`Root`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「`TestScript`の集合を作るクラス」を表す。
- 必須責務: TSVファイルを解析し、`limit`を超えないよう`TestScript`群に分配すること。
- 基底クラス: なし。
- 依存クラス: `TestGroup`、`TestCase`、`TestScript`（いずれも生成）。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `TestGroup` | 合成 | TSV行から生成しグループ化する |
| `TestCase` | 参照 | `TestGroup#add_test_case`を介して間接的に生成させる |
| `TestScript` | 合成 | `make_testscript`で生成し保持する |
| `Util` | 参照 | 文字列検証・数値チェック |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `DEFAULT_VALUES` | クラス定数 | Array（frozen） | `['to', 'be_successfully_executed', 'execute successfully', 'test_normal_sh:true', 'not_to', 'have_output(/error:/)', "don't have error in output", 'test_normal_sh_out:true']` | TSVで値が省略された場合の`test_1`〜`test_2_tag`8項目のデフォルト値（この順序で対応） | 不可（`freeze`済み） |
| `testscripts` | インスタンス属性（読み取り専用） | Array<TestScript> | 初期値は開始文字1件分の`TestScript` | 構築された`TestScript`群 | 不可（`setup`実行で更新） |
| `name` | インスタンス属性（読み取り専用） | String | 開始文字（例: `"A"`） | テストスクリプト命名に使う現在の文字 | 不可（`next_name`で内部更新） |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | TSVパス・命名開始文字・上限・make引数ベース名を保持し、最初の`TestScript`を作成する |
| `setup_test_group` | インスタンス | TSV1行を解析し`TestGroup`/`TestCase`を構築する |
| `setup_from_tsv` | インスタンス | TSVファイル全体を読み込み`TestGroup`群を構築する |
| `setup` | インスタンス | `TestGroup`群を`TestScript`単位に分配する |
| `make_testscript` | インスタンス | 新しい`TestScript`を生成し保持する |
| `next_name` | インスタンス | テストスクリプト命名用の文字を次に進める |
| `result` | インスタンス | 構築された`TestScript`群を返す |

## 6. 公開メソッド仕様

### 6.1 `initialize(tsv_path, start_char, limit, make_arg_basename)`

- **種別**: インスタンスメソッド（コンストラクタ）
- **前提条件**: `start_char` が非空文字列であること
- **引数**: `tsv_path`（String） — TSVファイルのパス、`start_char`（String） — 命名開始文字、`limit`（Integer） — `TestScript`あたりの上限、`make_arg_basename`（String） — make引数のベース名
- **戻り値**: 生成された `TestScriptGroup` インスタンス
- **処理**: 最初の`TestScript`（名前=`start_char`）を作成する
- **例外・エラー**: `MkspecAppError` — `start_char` が空文字列の場合

### 6.2 `setup_test_group(line, state)`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **引数**: `line`（String） — TSVの1行、`state`（Hash） — グループ名をキーとするハッシュ
- **戻り値**: `self`
- **処理**:
  1. `line`をタブ区切りで`tgroup`, `tcase`, `*tmp`に分解する
  2. `tgroup`/`tcase`が`nil`またはコメント（`#`始まり）なら何もせず終了する
  3. `tmp`の要素数が4を超える、または1〜7番目の要素が数値チェックに引っかかる場合は終了する
  4. `tgroup`/`tcase`の`-`と`.`を`_`に置換する
  5. `state[tgroup]`が無ければ`TestGroup`を新規作成する
  6. `DEFAULT_VALUES`と`tmp[0, 8]`から8項目のテスト条件配列を作る
  7. `TestGroup#add_test_case`でテストケースを追加する
- **状態変化・副作用**: `state`が破壊的に更新される

### 6.3 `setup_from_tsv()`

- **種別**: インスタンスメソッド
- **前提条件**: `@tsv_path`が実在するファイルであること
- **戻り値**: `Hash`（グループ名 => `TestGroup`）
- **処理**: TSVファイルを1行ずつ読み込み、コメント・空行を除いて`setup_test_group`を適用する

### 6.4 `setup()`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **戻り値**: `self`
- **処理**: `setup_from_tsv`で得た各`TestGroup`を現在の`TestScript`に`grouping`し、上限超過時は新しい`TestScript`（`next_name`）を作成して続行する
- **状態変化・副作用**: `testscripts`が更新される

### 6.5 `make_testscript(name)`

- **種別**: インスタンスメソッド
- **引数**: `name`（String） — 新しい`TestScript`の名前
- **戻り値**: 生成した`TestScript`
- **状態変化・副作用**: `testscripts`に追加される

### 6.6 `next_name()`

- **種別**: インスタンスメソッド
- **戻り値**: `String`（`name`を`succ`した次の文字列）
- **状態変化・副作用**: `name`が更新される

### 6.7 `result()`

- **種別**: インスタンスメソッド
- **戻り値**: `Array<TestScript>`（`testscripts`）

## 7. 入出力・永続化

- **入力ファイル**: `@tsv_path`が指すTSVファイル（`setup_from_tsv`で`File.readlines`により読み込む）

## 9. 不変条件・状態遷移

- `setup_test_group`実行中の`state`ハッシュは`setup_from_tsv`の呼び出し内でのみ生成・破棄される一時状態であり、インスタンスの永続状態としては保持されない。
- `testscripts`は`setup`実行前は要素数1（`initialize`で作成された最初の`TestScript`）、実行後は上限に応じて複数件になりうる。

## 10. エラー処理・終了コード

`TestScriptGroup.new`・`#setup`は`Mkscript#init_sub`（`Mkscript#init`経由、CLIの`begin...rescue`の**外側**）で呼び出される。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `start_char`が空文字列で`MkspecAppError`送出 | `bin/mkspec`では未捕捉、Rubyの未捕捉例外としてプロセス終了 | 1（Ruby既定） |
| `setup_test_group`内の`retirm self`（誤字）に到達 | `NoMethodError`が未捕捉のままプロセス終了 | 1（Ruby既定） |
| `setup`経由で`TestGroup`/`TestCase`の検証が失敗 | 同上 | 1（Ruby既定） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/testscriptgroup.rb` の `Mkspec::TestScriptGroup` |
