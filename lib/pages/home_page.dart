import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/my_app_bar.dart';
import 'package:flutter_music_player/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(title: 'P L A Y L I S T'),
      drawer: MyDrawer(),
    );
  }
}
