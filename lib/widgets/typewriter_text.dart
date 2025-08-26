// lib/widgets/typewriter_text.dart
import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed; // per character
  final TextStyle? style;
  final VoidCallback? onDone;
  final VoidCallback? onTick;

  const TypewriterText({
    Key? key,
    required this.text,
    this.speed = const Duration(milliseconds: 14),
    this.style,
    this.onDone,
    this.onTick,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  Timer? _timer;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.speed, (t) {
      if (!mounted) return;
      if (_count >= widget.text.length) {
        t.cancel();
        widget.onDone?.call();
      } else {
        setState(() => _count++);
        widget.onTick?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shown = _count.clamp(0, widget.text.length);
    return Text(widget.text.substring(0, shown), style: widget.style);
  }
}
