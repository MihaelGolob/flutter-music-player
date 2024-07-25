import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/neu_box.dart';
import 'package:flutter_music_player/models/song.dart';

class SongArtwork extends StatelessWidget {
  final Song song;
  const SongArtwork({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(song.albumArtImagePath),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.songName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      song.artistName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.favorite, color: Colors.red, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
