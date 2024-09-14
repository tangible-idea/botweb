import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class CircularFullProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minHeight: double.infinity, minWidth: double.infinity),
        color: Colors.black12,
        child: Center(
          child: Container(
              child: CircularProgress()),
        )
    );
  }
}