// lib/components/vyoora_scaffold.dart
import 'package:flutter/material.dart';

class VyooraScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool showChatFab;

  const VyooraScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.showChatFab = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: actions,
      ),
      body: SafeArea(child: body),
      floatingActionButton: showChatFab
          ? FloatingActionButton(
              tooltip: 'Ask Vyoora',
              onPressed: () => Navigator.pushNamed(context, '/chat'),
              child: const Icon(Icons.chat_bubble_outline),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
