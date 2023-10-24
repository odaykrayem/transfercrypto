import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlWidget(String url, {bool forceWebView = false}) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)
      .catchError((e) {
    log(e);
    return true;
  });
}
