name=lib/models/watch_history_model.dart
import 'package:hive/hive.dart';

part 'watch_history_model.g.dart';

@HiveType(typeId: 0)
class WatchHistoryEntry {
  @HiveField(0)
  final String animeId;

  @HiveField(1)
  final String animeTitle;

  @HiveField(2)
  final String animeCover;

  @HiveField(3)
  final int episode;

  @HiveField(4)
  final String episodeId;

  @HiveField(5)
  final int timestamp;

  @HiveField(6)
  final int duration;

  @HiveField(7)
  final String audioType;

  @HiveField(8)
  final int updatedAt;

  @HiveField(9)
  final int totalEpisodes;

  WatchHistoryEntry({
    required this.animeId,
    required this.animeTitle,
    required this.animeCover,
    required this.episode,
    required this.episodeId,
    required this.timestamp,
    required this.duration,
    required this.audioType,
    required this.updatedAt,
    required this.totalEpisodes,
  });
}

@HiveType(typeId: 1)
class WatchlistEntry {
  @HiveField(0)
  final String animeId;

  @HiveField(1)
  final String animeTitle;

  @HiveField(2)
  final String animeCover;

  @HiveField(3)
  final int totalEpisodes;

  @HiveField(4)
  final int addedAt;

  WatchlistEntry({
    required this.animeId,
    required this.animeTitle,
    required this.animeCover,
    required this.totalEpisodes,
    required this.addedAt,
  });
}
