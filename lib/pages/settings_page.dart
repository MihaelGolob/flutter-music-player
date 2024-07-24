import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/my_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: 'Settings',
      ),
    );
  }
}
