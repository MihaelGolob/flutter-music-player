import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase(), style: const TextStyle(letterSpacing: 5)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
