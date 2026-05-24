import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'snapbite_links.dart';

/// Opens the SnapBite store listing for the current platform.
Future<bool> openSnapBiteStoreListing() async {
  final url = Platform.isIOS
      ? SnapBiteLinks.appStoreUrl
      : SnapBiteLinks.playStoreUrl;
  final uri = Uri.tryParse(url);
  if (uri == null) {
    debugPrint('SnapBite store URL is invalid: $url');
    return false;
  }

  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e, st) {
    debugPrint('Failed to open SnapBite store: $e\n$st');
    return false;
  }
}
