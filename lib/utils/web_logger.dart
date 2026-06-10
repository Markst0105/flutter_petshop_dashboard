import 'package:flutter/foundation.dart';

class WebLogger {
  static void log(String message, {String level = 'log'}) {
    debugPrint('[APP] $message');
    
    if (kIsWeb) {
      try {
        final jsCode = '''
          console.$level('%c[AgendaPet] $message', 'color: #155DFC; font-weight: bold;');
        ''';
        // This would be used with js interop in a real implementation
      } catch (e) {
        debugPrint('Error logging to web console: $e');
      }
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  static void info(String message) => log(message, level: 'info');
  static void warn(String message) => log(message, level: 'warn');
}
