import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'components/chat_screen.dart';

void main() => runApp(const VyooraApp());

class VyooraApp extends StatelessWidget {
  const VyooraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vyoora',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const UploadScreen(),
        // IMPORTANT: Do NOT register /result because ResultScreen requires a "result" Map
        '/chat': (context) => const ChatScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
      ),
    );
  }
}
