import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'web_logger.dart';

class SupabaseDiagnostics {
  static Future<void> runDiagnostics() async {
    WebLogger.info('Running Supabase diagnostics...');

    try {
      final supabase = Supabase.instance.client;

      WebLogger.info('Supabase URL: ${supabase.realtime.endPoint}');
      WebLogger.info('Auth session: ${supabase.auth.currentSession?.user.email ?? "No session"}');

      // Try a simple health check
      try {
        final response = await supabase
            .from('booking')
            .select('bookingid')
            .limit(1)
            .timeout(const Duration(seconds: 10));

        WebLogger.info('✓ Database connection successful');
        WebLogger.info('Response type: ${response.runtimeType}');
        WebLogger.info('Response: $response');
      } catch (e) {
        WebLogger.error('✗ Database query failed', e);
        
        final errorMsg = e.toString();
        if (errorMsg.contains('Failed host lookup') || errorMsg.contains('No such host')) {
          WebLogger.error('DNS Resolution failed - Check internet connection');
        } else if (errorMsg.contains('CORS')) {
          WebLogger.error('CORS error - Check Supabase CORS configuration');
        } else if (errorMsg.contains('TimeoutException')) {
          WebLogger.error('Request timeout - Supabase server not responding');
        } else if (errorMsg.contains('SocketException')) {
          WebLogger.error('Socket error - Network/firewall issue');
        }
      }
    } catch (e) {
      WebLogger.error('Failed to run diagnostics', e);
    }
  }

  static String getSystemInfo() {
    return '''
Platform: ${defaultTargetPlatform.toString()}
Is Web: $kIsWeb
Debug Mode: $kDebugMode
    ''';
  }
}
