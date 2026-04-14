name=lib/screens/video_player_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit/media_kit.dart' as media_kit;
import 'package:hive_flutter/hive_flutter.dart';
import '../models/watch_history_model.dart';
import '../providers/anime_provider.dart';
import '../providers/episode_provider.dart';
import '../providers/stream_provider.dart';
import '../theme/constants.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String animeId;
  final String episodeId;
  final int episodeNumber;
  final String audioType;

  const VideoPlayerScreen({
    Key? key,
    required this.animeId,
    required this.episodeId,
    required this.episodeNumber,
    required this.audioType,
  }) : super(key: key);

  @override
  ConsumerState<VideoPlayerScreen> createState() =>
      _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late media_kit.Player player;
  late VideoController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    player = media_kit.Player();
    controller = VideoController(player);
    
    _loadStream();
  }

  Future<void> _loadStream() async {
    try {
      final streamResponse = await ref.read(
        streamProvider(StreamParams(
          episodeId: widget.episodeId,
          server: 'hd-2',
          type: widget.audioType,
        )).future,
      );

      if (streamResponse.success) {
        final url =
            streamResponse.results.streamingLink.file;
        await player.open(
          media_kit.Media(url),
        );
        
        _loadSavedProgress();
      }
    } catch (e) {
      print('Error loading stream: $e');
    }
  }

  Future<void> _loadSavedProgress() async {
    try {
      final box =
          Hive.box<WatchHistoryEntry>('watch_history');
      final key =
          '${widget.animeId}_${widget.episodeNumber}';
      final entry = box.get(key);
      if (entry != null && entry.timestamp > 0) {
        await player.seek(
          Duration(seconds: entry.timestamp),
        );
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  Future<void> _saveProgress() async {
    try {
      final box =
          Hive.box<WatchHistoryEntry>('watch_history');
      final key =
          '${widget.animeId}_${widget.episodeNumber}';
      
      final anime = await ref.read(
        animeDetailsProvider(widget.animeId).future,
      );

      final entry = WatchHistoryEntry(
        animeId: widget.animeId,
        animeTitle: anime.title,
        animeCover: anime.posterUrl,
        episode: widget.episodeNumber,
        episodeId: widget.episodeId,
        timestamp: player.state.position.inSeconds,
        duration: player.state.duration.inSeconds,
        audioType: widget.audioType,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        totalEpisodes: anime.episodes ?? 0,
      );

      await box.put(key, entry);
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  @override
  void dispose() {
    _saveProgress();
    player.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Video(controller: controller),
        ),
      ),
    );
  }
}
