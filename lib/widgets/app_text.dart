import 'package:flutter/material.dart';

@immutable
class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final double? textHeight;

  AppText(
      {Key? key,
      this.size = 16,
      required this.text,
      this.textHeight,
      this.color = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text,
      style: TextStyle(color: color, fontSize: size, height: textHeight));
}
