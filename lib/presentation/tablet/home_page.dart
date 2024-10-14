import 'package:flutter/material.dart';

class TabletHomePage extends StatefulWidget {
  const TabletHomePage({super.key});

  static String tag = '/';

  @override
  State<TabletHomePage> createState() => _TabletHomePageState();
}

class _TabletHomePageState extends State<TabletHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Container(
            width: size.width / 4,
            color: Colors.red,
          ),
          Container(
            width: (size.width) * 3 / 4,
            color: Colors.deepPurple,
          )
        ],
      ),
    ));
  }
}
