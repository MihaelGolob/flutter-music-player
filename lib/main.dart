import 'package:flutter/material.dart';
import 'package:flutter_music_player/models/playlist_provider.dart';
import 'package:flutter_music_player/pages/home_page.dart';
import 'package:flutter_music_player/pages/settings_page.dart';
import 'package:flutter_music_player/pages/song_player_page.dart';
import 'package:flutter_music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/songPlayer': (context) => const SongPlayerPage(),
      },
    );
  }
}
