# 外部仕様書 — `Mkscript` クラス

**完全修飾名**: `Mkspec::Mkscript`
**種別**: 通常クラス（アプリ調停クラス／CLIオーケストレータ）

本書は `docs/spec/internal/mkspec/mkscript.md` の内部仕様書、`lib/mkspec/mkscript.rb`、および呼び出し元である `bin/mkspec` のソースコードに基づき、mkspec本体の外部仕様書テンプレートに従って作成する。

## 1. 概要

mkspecのCLIエントリーポイントを担うアプリ調停クラス。コマンドラインオプションの解析、`GlobalConfig`/`Config`の初期化、TSVファイルからの`TestScriptGroup`構築、テンプレート・データYAML・RSpec仕様ファイルの生成までの一連のフローを統括する。責務外の事項として、実際のファイル内容の合成（`Item`/`Root`/`Templatex`の責務）や設定値の保持そのもの（`GlobalConfig`の責務）は範囲外。

## 2. フレームワーク上の位置付け

- クラス名は「specを作る（make spec）ためのスクリプト」を表す。
- 必須責務: CLI引数を受け取り、ファイル生成フロー全体を制御すること。
- 基底クラス: なし。
- 依存クラス: `GlobalConfig`・`Config`・`TestScriptGroup`・`TestScript`・`Setting`・`Templatex`・`Root`・`Util`・`Loggerxcm`・`State`。

## 3. 依存関係

| 依存先 | 関係 | 用途 |
|--------|------|------|
| `GlobalConfig` | 合成 | CLI/環境変数由来の設定構築 |
| `Config` | 合成 | 出力ディレクトリ構成の管理 |
| `TestScriptGroup` | 合成 | TSVからのテストスクリプト構築 |
| `TestScript` | 参照 | 生成された各出力単位の反復処理 |
| `Setting` | 合成 | 各`TestScript`に対応する設定の生成 |
| `Templatex` | 合成 | テンプレート生成 |
| `Root` | 合成 | spec文字列生成 |
| `Util` | 参照 | 環境変数解決・ファイル操作 |
| `Loggerxcm` | 参照 | ログ出力 |
| `State` | 参照 | 処理結果の保持・判定 |
| `OptionParser`（標準ライブラリ） | 合成 | CLIオプション解析 |
| `Rufo::Formatter`（外部gem） | 参照 | 生成したRubyコードの整形 |

## 4. 公開属性・定数

| 名前 | 種別 | 型 | 既定値/値域 | 意味 | 変更可否 |
|------|------|----|------|------|---------|
| `gco` | インスタンス属性 | GlobalConfig | `setup_globalconfig`実行後に設定 | 構築済みのグローバル設定 | 可 |
| `new_count` | インスタンス属性 | Boolean | `false` | `-n`オプションに対応するフラグ | 可 |

## 5. 公開メソッド一覧

| 名前 | 種別 | 概要 |
|------|------|------|
| `initialize` | インスタンス | 環境変数からディレクトリ/ファイル情報を構築する |
| `check_cli_options` | インスタンス | CLIオプションを解析し設定を検証する |
| `check_state_and_show_useage_and_state_message` | インスタンス | 状態に応じたメッセージ表示と終了コード決定を行う |
| `init` | インスタンス | `GlobalConfig`/`Config`/`TestScriptGroup`/`Setting`を構築する |
| `create_files` | インスタンス | テンプレート/データおよびspecファイルを生成する |
| `self.format` | クラス | Rubyコードを整形する |

## 6. 公開メソッド仕様

### 6.1 `initialize()`

- **種別**: インスタンスメソッド（コンストラクタ）
- **戻り値**: 生成された`Mkscript`インスタンス
- **処理**: `Util.adjust_dirs_and_files`で環境変数からディレクトリ/ファイル情報を構築する

### 6.2 `check_cli_options(argv)`

- **種別**: インスタンスメソッド
- **前提条件**: なし
- **引数**: `argv`（Array<String>） — コマンドライン引数（詳細は§8参照）
- **戻り値**: `STATE.change`の戻り値、または`validate_setting`の戻り値（呼び出し側は戻り値ではなく`STATE`の状態を見て判断する設計）
- **処理**:
  1. `OptionParser`で各オプションを解析する
  2. `-v`指定時は`STATE`を`FINISH`にする
  3. `setup_globalconfig`で`GlobalConfig`を構築する
  4. `validate_setting`で必須オプションの充足を検証する
- **状態変化・副作用**: `STATE`が更新されうる
- **例外・エラー**: 実装上の欠陥により`validate_setting`内で`NameError`が発生しうる（§10参照）

### 6.3 `check_state_and_show_useage_and_state_message()`

- **種別**: インスタンスメソッド
- **戻り値**: `Integer`（終了コード）、または`STATE`が成功状態の場合`nil`
- **処理**: `STATE`が`finish`または不成功の場合にメッセージを表示し終了コードを返す

### 6.4 `init()`

- **種別**: インスタンスメソッド
- **前提条件**: `check_cli_options`が完了していること
- **戻り値**: Boolean
- **処理**: `Config`インスタンスを生成し、TSVファイルから`TestScriptGroup`・`Setting`群を構築する
- **状態変化・副作用**: 出力ディレクトリの作成、`Config`/`TestScriptGroup`/`Setting`インスタンスの構築
- **例外・エラー**: `MkspecAppError` — `gco.ost.top_dir`が取得できない場合。内部で呼び出す`Config#setup`/`TestScriptGroup#setup`/`Setting#setup`が送出する`MkspecDebugError`/`MkspecAppError`もそのまま伝播する

### 6.5 `create_files()`

- **種別**: インスタンスメソッド
- **前提条件**: `init`が完了していること
- **戻り値**: `[template_and_data, spec, data_dir_index]`、または`nil`
- **処理**: `-c`オプション（`spec`/`tad`/`all`等）に応じてテンプレート/データ生成とspec生成を実行する
- **状態変化・副作用**: テンプレート・データYAML・specファイルがファイルシステムに出力される
- **例外・エラー**: `MkspecDebugError`/`MkspecAppError` — 生成過程で発生した各種エラー（詳細は§10）

### 6.6 `self.format(code)`

- **種別**: クラスメソッド
- **引数**: `code`（String） — 整形対象のRubyコード
- **戻り値**: `String`（整形後のコード）
- **処理**: `Rufo::Formatter.format(code)`を呼び出す

## 7. 入出力・永続化

- **入力ファイル**: TSVファイル（`-t`）、global.yml（`-g`）、specific.yml（`-G`）
- **出力ファイル**: RSpec仕様ファイル（`_spec.rb`）、テンプレートファイル（`content.txt`）、データYAMLファイル
- **ログ**: `-L`で指定したログディレクトリへの出力（`Loggerxcm.init`経由）

## 8. CLI境界（`Mkscript`）

`bin/mkspec`から次の順序で呼び出される。

```
mkscript = Mkspec::Mkscript.new
mkscript.check_cli_options(ARGV)
exit_code = mkscript.check_state_and_show_useage_and_state_message
exit(exit_code) if exit_code

mkscript.init

begin
  mkscript.create_files
rescue Mkspec::MkspecDebugError => exc ... end
rescue Mkspec::MkspecAppError => exc ... end
rescue StandardError => exc ... end
end
exit_code ||= 0
exit(exit_code)
```

**コマンドライン構文**:

```
mkspec -o output_dir -t tsv -c cmd -s ch -l limit -d script_dir -i tad_dir \
       -g global_yaml -x original_output_dir -y target_cmd_1 -z target_cmd_2 \
       -G specific_yaml -L log_dir -n
```

**オプション一覧**:

| オプション | 引数 | 意味 | 必須 |
|-----------|------|------|------|
| `-o` | output_dir | 出力ディレクトリ | 必須（未指定時は`GlobalConfig`側の値で補完） |
| `-t` | tsv | TSVファイルパス | 必須（同上） |
| `-c` | cmd | `spec`/`tad`/`all`のいずれか | 必須 |
| `-s` | ch | 開始文字（テストスクリプト命名用） | 必須 |
| `-l` | limit | `TestScript`あたりのテストケース数上限 | 必須 |
| `-d` | script_dir | スクリプト出力ディレクトリ | 任意 |
| `-i` | tad_dir | テンプレート/データディレクトリ | 必須（ただし§10参照） |
| `-g` | global_yaml | global.ymlのパス | 必須 |
| `-x` | original_output_dir | 元の出力ディレクトリ | 必須 |
| `-y` | target_cmd_1 | 対象コマンド1のパス | 必須 |
| `-z` | target_cmd_2 | 対象コマンド2のパス | 必須 |
| `-G` | specific_yaml | specific.ymlのパス | 必須 |
| `-L` | log_dir | ログディレクトリ | 必須 |
| `-n` | なし | 出力ディレクトリの自動連番付与 | 任意 |
| `-v` | なし | バージョン表示（指定時は他の検証を行わず終了） | 任意 |

## 9. 不変条件・状態遷移

`Mkscript`の実行は概ね次の状態遷移をたどる。

1. `check_cli_options`実行前: 未設定
2. `check_cli_options`完了後: `gco`（`GlobalConfig`）が構築され、`STATE`が成功または特定のCLIエラーコードのいずれかを保持する
3. `init`完了後: `Config`・`TestScriptGroup`・`Setting`群が構築される（この間`STATE`は通常変更されない）
4. `create_files`完了後: `STATE`が成功、または`CANNOT_MAKE_SPEC_FILE`等の生成系エラーコードのいずれかを保持する

各段階の失敗は、後段の処理が前段の成果物（`gco`/`@config`/`@setting_and_testscript_array`）の存在を前提とするため、途中で失敗した場合に後続を安全にスキップする仕組みは限定的である（§10参照）。

## 10. エラー処理・終了コード

CLI全体の終了コードは`bin/mkspec`が決定する。**`mkscript.init`の呼び出しが`begin...rescue`の外側にある**ことが、本クラスの終了コード体系における最も重要な制約である。

| 事象 | 挙動 | 終了コード |
|------|------|-----------|
| `check_cli_options`のオプション解析自体が失敗（`OptionParser`が例外送出） | `STATE`が`INVALID_CMDLINE_OPTION_ERROR`(9)に変更され、`check_state_and_show_useage_and_state_message`が`STATE.show_message`を返し、`bin/mkspec`が`exit(exit_code)`する | 9 |
| `-v`指定 | `STATE`が`FINISH`(1)になり、`check_state_and_show_useage_and_state_message`が`1`を返し即座に`exit`する | 1（`FINISH`） |
| 必須オプション（`-o`/`-t`/`-c`/`-s`/`-l`/`-y`/`-z`/`-x`/`-L`）未指定 | `STATE`が対応するエラーコード（10〜19、22等）に変更され即座に`exit`する | 10〜22の該当コード |
| `-i`（tad_dir）未指定 | 未定義の`Mkspec::CMDLINE_OPTION_ERROR_I`定数を参照するため、CLIエラーとしてではなく`NameError`が未捕捉のままプロセスが終了する | 1（Ruby既定。意図した専用コードにはならない） |
| `validate_setting`終盤の`argv`/`argv_dup`参照 | 同様に`NameError`が未捕捉のままプロセス終了 | 1（Ruby既定） |
| `init`（`Config#setup`・`TestScriptGroup#setup`・`Setting#setup`・`GlobalConfig#top_dir`を含む）が`MkspecDebugError`/`MkspecAppError`/その他の`StandardError`を送出 | `begin...rescue`の外側のため、いずれの`rescue`にも捕捉されず**Rubyの未捕捉例外としてプロセスが終了する** | 1（Ruby既定。フレームワーク定義の`100`/`101`にはならない） |
| `create_files`実行中に`MkspecDebugError`送出（`STATE`未変更時） | `bin/mkspec`の`rescue Mkspec::MkspecDebugError`で捕捉 | 100（`MKSPEC_DEBUG_ERROR`） |
| `create_files`実行中に`MkspecAppError`送出（`STATE`未変更時） | `bin/mkspec`の`rescue Mkspec::MkspecAppError`で捕捉 | 101（`MKSPEC_APP_ERROR`） |
| `create_files`実行中に`STATE`が事前変更済み（例:`CANNOT_MAKE_SPEC_FILE`=24、`CANNOT_WRITE_YAML_FILE`=50）の状態で`MkspecDebugError`/`MkspecAppError`送出 | 対応する`rescue`節で捕捉され、`STATE.show_message`が返すコードで終了する | `STATE`に設定済みの値（24/25/50/60等） |
| `create_files`実行中にそれ以外の`StandardError`が送出され、`STATE`が一度も変更されていない | `rescue StandardError`で捕捉されるが`STATE.show_message`は初期値`SUCCESS`(0)を返す。エラーメッセージは表示されるが**終了コードは0（成功扱い）** | 0（実質的なエラーの隠蔽。§設計上の注意相当の重大な欠陥） |
| すべて成功 | 正常終了 | 0（`SUCCESS`） |

## 11. 実装上の対応（参考）

本節は実装を拘束しない。

| 役割 | クラス・モジュール |
|------|------|
| クラス本体 | `lib/mkspec/mkscript.rb` の `Mkspec::Mkscript` |
| CLIエントリーポイント（本クラスの呼び出し元） | `bin/mkspec` |
