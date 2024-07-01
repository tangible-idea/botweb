import 'package:flutter/material.dart';
import 'package:prayers/styles/my_color.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? fab;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;

  const DefaultLayout({Key? key, required this.title, required this.body, this.actions, this.fab, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: AppBar(
        backgroundColor: MyColor.kLightBackground,
        title: Text(title),
        actions: actions,
      ),
      floatingActionButton: fab, // This trailing comma makes auto-formatting nicer for build methods.
      backgroundColor: MyColor.kLightBackground,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: body,
      ));
  }
}
