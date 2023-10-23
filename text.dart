import 'package:flutter/material.dart';

class text extends StatelessWidget {
  final String t;
  final Color c;
  final double s;
  final FontWeight w;

  const text(
      {super.key,
      required this.t,
      required this.c,
      required this.s,
      required this.w});

  @override
  Widget build(BuildContext context) {
    return Text(
      t,
      style: TextStyle(fontWeight: w, fontSize: s, color: c),
    );
  }
}