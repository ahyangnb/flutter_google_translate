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
    int count = 1;
    // Begin ping process and listen for output
    // Register DartPingIOS
    DartPingIOS.register();
    // Create ping object with desired args
    final ping = Ping(url, count: count);

    Completer<bool> completer = Completer<bool>();
    List<PingData> detectList = [];
    pingStream = ping.stream.listen((event) async {
      try {
        gLogger.d("ping::$event, error:${event.error?.error}");
        if (event.summary?.received != null && event.summary!.received == 0) {
          completer.complete(false);
          return;
        }
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
      } catch (e) {
        completer.complete(false);
        gLogger.d("ping::error::${e.toString()}");
      }
    });
    // Google can not connect.
    return completer.future;
  }

  static void cancelPing() {
    if (pingStream != null) {
      if (!pingStream!.isPaused) pingStream?.cancel();
      pingStream = null;
    }
  }
}
