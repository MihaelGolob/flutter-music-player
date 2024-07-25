import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/my_app_bar.dart';
import 'package:flutter_music_player/components/neu_box.dart';
import 'package:flutter_music_player/components/songView/song_artwork.dart';
import 'package:flutter_music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key});

  String formatDuration(Duration duration) {
    return '${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  double calculateSliderValue(Duration currentDuration, Duration totalDuration) {
    if (totalDuration.inSeconds == 0) {
      return 0;
    }
    return (currentDuration.inSeconds / totalDuration.inSeconds * 100).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Playlist',
          displayAction: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Consumer<PlaylistProvider>(builder: (context, provider, child) {
          final song = provider.playlist[provider.currentSongIndex!];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SongArtwork(song: song),
                const SizedBox(height: 25),
                // song duration
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDuration(provider.currentDuration), style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                          IconButton(
                            icon: Icon(Icons.shuffle, color: provider.shuffle ? Colors.blue[700] : Theme.of(context).colorScheme.inversePrimary),
                            onPressed: () => provider.toggleShuffle(),
                          ),
                          IconButton(
                            icon: Icon(Icons.repeat, color: provider.repeat ? Colors.blue[700] : Theme.of(context).colorScheme.inversePrimary),
                            onPressed: () => provider.toggleRepeat(),
                          ),
                          Text(formatDuration(provider.totalDuration), style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)),
                      child: Slider(
                        value: calculateSliderValue(provider.currentDuration, provider.totalDuration),
                        min: 0,
                        max: 100,
                        activeColor: Colors.blue[700],
                        inactiveColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          provider.seek(Duration(seconds: (value * provider.totalDuration.inSeconds / 100).round()));
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),

                // playback controls
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          provider.playPreviousSong();
                        },
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          provider.pauseOrResume();
                        },
                        child: NeuBox(
                          child: Icon(provider.isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (provider.playNextSong() == 0) {
                            provider.stop();
                            Navigator.pop(context);
                          }
                        },
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
