import 'dart:developer' as dev;

abstract final class Logger {
  static void log(String msg, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      'Error message: $msg\n\nError: $error\n\n StackTrace: $stackTrace',
    );
  }
}
