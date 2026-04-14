name=lib/services/database_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/watch_history_model.dart';

class DatabaseService {
  static const String watchHistoryBoxName = 'watch_history';
  static const String watchlistBoxName = 'watchlist';

  late Box<WatchHistoryEntry> _watchHistoryBox;
  late Box<WatchlistEntry> _watchlistBox;

  Future<void> init() async {
    _watchHistoryBox = Hive.box<WatchHistoryEntry>(watchHistoryBoxName);
    _watchlistBox = Hive.box<WatchlistEntry>(watchlistBoxName);
  }

  Future<void> saveWatchHistory(WatchHistoryEntry entry) async {
    final key =
        '${entry.animeId}_${entry.episode}';
    await _watchHistoryBox.put(key, entry);
  }

  Future<WatchHistoryEntry?> getWatchHistory(String animeId, int episode) async {
    final key = '${animeId}_$episode';
    return _watchHistoryBox.get(key);
  }

  Future<List<WatchHistoryEntry>> getContinueWatching() async {
    final entries = _watchHistoryBox.values.toList();
    final uniqueMap = <String, WatchHistoryEntry>{};

    for (final entry in entries) {
      if (entry.timestamp > 30 &&
          entry.duration > 0 &&
          (entry.timestamp / entry.duration) < 0.9) {
        if (!uniqueMap.containsKey(entry.animeId)) {
          uniqueMap[entry.animeId] = entry;
        } else if (entry.updatedAt >
            uniqueMap[entry.animeId]!.updatedAt) {
          uniqueMap[entry.animeId] = entry;
        }
      }
    }

    return uniqueMap.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<List<WatchHistoryEntry>> getAllHistory() async {
    final entries = _watchHistoryBox.values.toList();
    final uniqueMap = <String, WatchHistoryEntry>{};

    for (final entry in entries) {
      if (!uniqueMap.containsKey(entry.animeId)) {
        uniqueMap[entry.animeId] = entry;
      } else if (entry.updatedAt >
          uniqueMap[entry.animeId]!.updatedAt) {
        uniqueMap[entry.animeId] = entry;
      }
    }

    return uniqueMap.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> deleteWatchHistory(String animeId, int episode) async {
    final key = '${animeId}_$episode';
    await _watchHistoryBox.delete(key);
  }

  Future<void> deleteAllWatchHistory(String animeId) async {
    final keysToDelete = <String>[];
    for (final entry in _watchHistoryBox.values) {
      if (entry.animeId == animeId) {
        keysToDelete.add('${entry.animeId}_${entry.episode}');
      }
    }
    for (final key in keysToDelete) {
      await _watchHistoryBox.delete(key);
    }
  }

  Future<void> addToWatchlist(WatchlistEntry entry) async {
    await _watchlistBox.put(entry.animeId, entry);
  }

  Future<List<WatchlistEntry>> getWatchlist() async {
    final entries = _watchlistBox.values.toList();
    entries.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return entries;
  }

  Future<bool> isInWatchlist(String animeId) async {
    return _watchlistBox.containsKey(animeId);
  }

  Future<void> removeFromWatchlist(String animeId) async {
    await _watchlistBox.delete(animeId);
  }

  Future<void> clearWatchHistory() async {
    await _watchHistoryBox.clear();
  }

  Future<void> clearWatchlist() async {
    await _watchlistBox.clear();
  }
}
