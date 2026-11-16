import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  // Otomatis menyesuaikan alamat localhost untuk Web, Android Emulator, atau Desktop/iOS
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3000/api';
    }
    if (Platform.isAndroid) {
      // 10.0.2.2 adalah alias localhost komputer pada Android Emulator
      // Jika pakai HP fisik (USB/WiFi), ganti dengan IP Laptop Anda (misal: http://192.168.1.10:3000/api)
      return 'http://10.0.2.2:3000/api';
    }
    return 'http://localhost:3000/api';
  }

  static String get loginUrl => '$baseUrl/login.php';
  static String get registerUrl => '$baseUrl/register.php';
  static String get usersUrl => '$baseUrl/users.php';
  static String get ticketsUrl => '$baseUrl/tickets.php';
}
