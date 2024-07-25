import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  PlaylistProvider() {
    listenToDuration();

    _playlist = List.from(_originalPlaylist);
  }

  final List<Song> _originalPlaylist = [
    Song(
      songName: "Can't hold us",
      artistName: "Macklemore & Ryan Lewis",
      albumArtImagePath: 'assets/images/cantholdus.jpg',
      audioPath: 'music/cantholdus.mp3',
    ),
    Song(
      songName: 'Believer',
      artistName: 'Imagine Dragons',
      albumArtImagePath: 'assets/images/believer.jpg',
      audioPath: 'music/believer.mp3',
    ),
    Song(
      songName: 'Angels',
      artistName: 'Tom Walker',
      albumArtImagePath: 'assets/images/angels.jpg',
      audioPath: 'music/angels.mp3',
    ),
  ];

  List<Song> _playlist = [];

  int? _currentSongIndex;

  // G E T T E R S
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  // S E T T E R S
  set currentSongIndex(int? index) {
    _currentSongIndex = index;
    notifyListeners();
  }

  // A U D I O   P L A Y E R
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;
  bool _repeat = false;
  bool _shuffle = false;

  // getters
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get repeat => _repeat;
  bool get shuffle => _shuffle;

  // setters
  set playSongAtIndex(int index) {
    _currentSongIndex = index;
    play();
    notifyListeners();
  }

  void toggleRepeat() {
    _repeat = !_repeat;
    notifyListeners();
  }

  void toggleShuffle() {
    _shuffle = !_shuffle;

    if (_shuffle) {
      final currentSong = _playlist[_currentSongIndex!];
      _playlist.shuffle();
      _playlist.remove(currentSong);
      _playlist.insert(0, currentSong);
      _currentSongIndex = 0;
    } else {
      final currentSong = _playlist[_currentSongIndex!];
      _playlist = List.from(_originalPlaylist);
      _currentSongIndex = _playlist.indexOf(currentSong);
    }

    notifyListeners();
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currentDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));

    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  void seek(Duration duration) async {
    await _audioPlayer.seek(duration);
  }

  int playNextSong() {
    if (_currentSongIndex == null) return 0;

    if (_currentSongIndex! < _playlist.length - 1) {
      _currentSongIndex = _currentSongIndex! + 1;
    } else {
      if (repeat) {
        _currentSongIndex = 0;
      } else {
        return 0;
      }
    }

    play();

    return 1;
  }

  void playPreviousSong() {
    if (_currentSongIndex == null) return;

    if (_currentDuration.inSeconds > 2) {
      _currentDuration = Duration.zero;
      notifyListeners();
      play();
      return;
    }

    if (_currentSongIndex! > 0) {
      _currentSongIndex = _currentSongIndex! - 1;
    } else {
      _currentSongIndex = 0;
    }
    play();
  }
}
