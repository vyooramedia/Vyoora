// lib/config.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Returns the correct backend base URL depending on platform.
///
/// - Web: localhost:5001
/// - Android Emulator: 10.0.2.2:5001 (special host loopback)
/// - iOS Simulator: 127.0.0.1:5001
/// - iOS/Android physical devices: use your deployed URL (Render/Heroku)
String apiBase() {
  if (kIsWeb) {
    return 'http://localhost:5001';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:5001';
  } else if (Platform.isIOS) {
    return 'http://127.0.0.1:5001';
  } else {
    return 'http://127.0.0.1:5001';
  }
}
