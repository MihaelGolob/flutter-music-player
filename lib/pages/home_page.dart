import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/my_app_bar.dart';
import 'package:flutter_music_player/components/my_drawer.dart';
import 'package:flutter_music_player/components/homeView/song_tile.dart';
import 'package:flutter_music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PlaylistProvider _playlistProvider;

  @override
  void initState() {
    super.initState();
    _playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int index) {
    _playlistProvider.currentSongIndex = index;
    _playlistProvider.play();
    Navigator.pushNamed(context, '/songPlayer');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(title: 'Playlist'),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.playlist.length,
            itemBuilder: (context, index) {
              final song = value.playlist[index];
              return SongTile(
                title: song.songName,
                artist: song.artistName,
                albumArtPath: song.albumArtImagePath,
                onTap: () => goToSong(index),
              );
            }),
      ),
    );
  }
}
