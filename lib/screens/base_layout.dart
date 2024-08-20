import 'package:flutter/material.dart';
import 'package:prayers/styles/my_color.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 35),
      child: Container(child: body),
    );
  }
}
