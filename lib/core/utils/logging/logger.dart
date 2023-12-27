import 'package:logger/logger.dart';

/// A utility class for logging messages, errors, and exceptions using the 'logger' package.
///
/// This class encapsulates logging functionality to handle various types of logs
/// such as debug messages, info messages, warnings, errors, and unhandled exceptions.
class AppLogger {
  /// The underlying Logger instance from the 'logger' package.
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  /// Logs a debug message.
  ///
  /// [message]: The message to be logged.
  /// [error]: Optional. An error object associated with the log.
  /// [stackTrace]: Optional. The stack trace associated with the log.
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an info message.
  ///
  /// [message]: The message to be logged.
  /// [error]: Optional. An error object associated with the log.
  /// [stackTrace]: Optional. The stack trace associated with the log.
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Logs a warning message.
  ///
  /// [message]: The message to be logged.
  /// [error]: Optional. An error object associated with the log.
  /// [stackTrace]: Optional. The stack trace associated with the log.
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an error message.
  ///
  /// [message]: The message to be logged.
  /// [error]: Optional. An error object associated with the log.
  /// [stackTrace]: Optional. The stack trace associated with the log.
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Logs an unhandled exception along with its stack trace.
  ///
  /// [exception]: The unhandled exception that occurred.
  /// [stackTrace]: The stack trace associated with the unhandled exception.
  static void logException(dynamic exception, StackTrace stackTrace) {
    _logger.e('Unhandled exception occurred',
        error: exception, stackTrace: stackTrace);
    // Additional actions like reporting to crash analytics services could be performed here.
  }
}
