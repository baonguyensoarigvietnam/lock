import 'package:url_launcher/url_launcher.dart';

/// Opens external links (web pages, mail apps) safely.
class UrlLauncherUtility {
  const UrlLauncherUtility._();

  /// Opens [url] in an external app. Returns `false` if nothing handled it.
  static Future<bool> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return _launch(uri);
  }

  /// Opens the user's mail app with a pre-filled message.
  static Future<bool> sendEmail({
    required String to,
    String? subject,
    String? body,
  }) {
    final query = <String, String>{
      'subject': ?subject,
      'body': ?body,
    };
    final uri = Uri(
      scheme: 'mailto',
      path: to,
      query: query.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&'),
    );
    return _launch(uri);
  }

  static Future<bool> _launch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
