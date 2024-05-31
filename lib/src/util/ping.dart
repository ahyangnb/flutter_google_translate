import 'dart:async';

import 'package:dart_ping/dart_ping.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter_google_translate/flutter_google_translate.dart';

class PingGoogleUtil {
  static StreamSubscription? pingStream;

  static Future<bool> pingGoogle() async {
    return ping('google.com');
  }

  static Future<bool> ping(String url) async {
    int count = 2;
    // Begin ping process and listen for output
    // Register DartPingIOS
    DartPingIOS.register();
    // Create ping object with desired args
    final ping = Ping(url, count: count);

    Completer<bool> completer = Completer<bool>();
    List<PingData> detectList = [];
    pingStream = ping.stream.listen((event) async {
      gLogger.d("ping::$event, error:${event.error?.error}");
      detectList.add(event);
      if (detectList.length == count) {
        await ping.stop();

        /// End the ping event.
        cancelPing();
        final errorList =
            detectList.where((element) => element.error != null).toList();
        completer.complete(errorList.length < count);
      }
      // event.response.
    });
    // Google can not connect.
    return completer.future;
  }

  static void cancelPing() {
    pingStream?.cancel();
    pingStream = null;
  }
}
