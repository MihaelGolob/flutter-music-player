import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? displayAction;
  const MyAppBar({super.key, required this.title, this.displayAction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase(), style: const TextStyle(letterSpacing: 10, fontSize: 17)),
      centerTitle: true,
      actions: [
        if (displayAction ?? false)
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
