# Loggerxcm0 — クラス内部仕様書

**ファイル**: `lib/mkspec/loggerxcm.rb`
**継承**: なし

## 概要

ファイルおよび標準出力へのログ出力を行う基底実装クラス。ログレベル（debug/info/warn/error/fatal）ごとの出力メソッド、ログファイルのローテーション、`$stdout`を一時的に`StringIO`へ差し替えるユーティリティ等を、すべて`class << self`によるクラスメソッド（`Loggerxcm0.debug`等）として提供する。`Loggerxcm`・`Loggerxcmcli`・`Loggerxcmspec`の3つの空サブクラス（それぞれ個別の仕様書を参照）が本クラスを継承する。

---

## クラス定数

| 定数名 | 値 | 説明 |
|--------|----|------|
| `LOG_FILENAME_BASE` | `"#{Time.now.strftime('%Y%m%d-%H%M%S')}.log".freeze` | デフォルトのログファイル名（クラス読み込み時に一度だけ確定する固定値） |

---

## インスタンス変数（クラスインスタンス変数）

| 変数名 | 型 | 説明 |
|--------|----|------|
| `@log_file` | Logger, nil | ファイル出力用の`Logger` |
| `@log_stdout` | Logger, nil | 標準出力用の`Logger` |
| `@stdout_backup` | IO | `$stdout`の退避先 |
| `@stringio` | StringIO | `$stdout`差し替え用バッファ |
| `@valid` | Boolean | `init`完了後に`true`になる初期化済みフラグ |
| `@error_count` | Integer | 初期化中に発生したエラー数 |
| `@log_dir_pn` | Pathname | ログディレクトリ |
| `@limit_of_num_of_files` | Integer | 保持するログファイル数の上限（デフォルト5） |

---

## メソッド

すべて `self.` によるクラスメソッド（シングルトンメソッド）として定義される。

### `ensure_quantum_log_files(log_dir_pn, limit_of_num_of_files, prefix) -> nil`

`prefix`に一致する既存ログファイルをmtime順に並べ、上限を超える古いファイルを削除する。

### `init(prefix, fname, log_dir, stdout_flag, level = :info) -> nil`

ログ出力先（ファイル/標準出力）とログレベルを初期化する。既に`@log_file`が設定済みなら何もしない。

処理フロー:
  1. ログディレクトリを作成し、古いログファイルを整理する
  2. `stdout_flag`が真なら標準出力用の`Logger`を準備する
  3. `fname`の指定（`false`/`:default`/文字列）に応じてログファイルを準備する
  4. ログフォーマット・ログレベルを登録する
  5. 初期化完了フラグ`@valid`を`true`にし、各レベルの疎通確認メッセージを出力する

### `setup_logger_stdout(log_stdout) -> Logger, nil`

標準出力用の`Logger`を生成する（既にあれば何もしない）。

### `setup_logger_file(log_file, log_dir, fname) -> Logger, nil`

ファイル用の`Logger`を生成する（既にあれば何もしない）。`Errno::EACCES`等の例外を捕捉する。

### `register_log_format(obj)` / `register_log_level(level) -> nil`

ログファイル・標準出力`Logger`にフォーマッタ/レベルを設定する。

### `to_string(value) -> String, Object`

`value`が配列の場合、`$stdout`を一時的に`StringIO`へ差し替えてキャプチャした文字列を返す実装だが、配列の内容自体を出力する処理が無いため常に空文字列を返す（設計上の注意を参照）。配列でなければ`value`をそのまま返す。

### `show(value) -> Boolean`

`value`が配列なら各要素を`Util.puts_valid_str`で出力する。それ以外の場合は未定義のローカル変数を参照する（設計上の注意を参照）。

### `error_sub(value) -> String`

`to_string`で文字列化した上で`@log_file`/`@log_stdout`の`error`メソッドを呼び出す。

### `error(value)` / `debug(value)` / `info(value)` / `warn(value)` / `fatal(value) -> Boolean`

対応するログレベルでメッセージを出力する（`@valid`が`false`の間は実際の出力を行わない）。

### `close -> nil`

ログファイルをクローズし状態をリセットする（設計上の注意を参照）。

---

## 依存

| クラス/変数 | 用途 |
|-------------|------|
| `Logger`（標準ライブラリ） | ファイル/標準出力へのログ実装 |
| `Util.puts_valid_str` | 文字列出力 |

---

## 設計上の注意

- `to_string`は配列を受け取った場合に`$stdout`をキャプチャする仕組みを用意しているが、配列の内容を実際に`puts`する処理が存在しないため、常に空文字列を返すだけになっている。
- `show(value)`は非配列の場合に`Util.puts_valid_str(str)`を呼んでいるが、`str`はこのメソッド内で定義されておらず`NameError`になる。
- `setup_logger_stdout`内の`pust exc.message`はタイプミス（本来`puts`）であり、到達すると`NoMethodError`になる。
- `close`内の`retrun unless @valid`はタイプミス（本来`return`）であり、`close`を呼び出すと常に`NoMethodError`になる。
- `Loggerxcm`/`Loggerxcmcli`/`Loggerxcmspec`はいずれも空のサブクラスだが、`@log_file`等はクラスインスタンス変数であり、Rubyの仕様上サブクラス・親クラス間で共有されない。そのため実装コードは完全に共有しつつ、`init`を呼んだクラスごとに独立したログファイル/標準出力状態を持つ「名前空間の異なるロガー」として機能する。
