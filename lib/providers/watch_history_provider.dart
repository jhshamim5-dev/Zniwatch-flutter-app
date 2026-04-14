name=lib/providers/watch_history_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/watch_history_model.dart';

final watchHistoryProvider =
    FutureProvider<List<WatchHistoryEntry>>((ref) async {
  final box = Hive.box<WatchHistoryEntry>('watch_history');
  final entries = box.values.toList();
  final uniqueMap = <String, WatchHistoryEntry>{};

  for (final entry in entries) {
    if (entry.timestamp > 30 &&
        entry.duration > 0 &&
        (entry.timestamp / entry.duration) < 0.9) {
      if (!uniqueMap.containsKey(entry.animeId)) {
        uniqueMap[entry.animeId] = entry;
      } else if (entry.updatedAt > uniqueMap[entry.animeId]!.updatedAt) {
        uniqueMap[entry.animeId] = entry;
      }
    }
  }

  return uniqueMap.values.toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
});

final watchlistProvider =
    FutureProvider<List<WatchlistEntry>>((ref) async {
  final box = Hive.box<WatchlistEntry>('watchlist');
  final entries = box.values.toList();
  entries.sort((a, b) => b.addedAt.compareTo(a.addedAt));
  return entries;
});

final watchlistNotifierProvider =
    StateNotifierProvider<WatchlistNotifier, List<WatchlistEntry>>((ref) {
  return WatchlistNotifier();
});

class WatchlistNotifier extends StateNotifier<List<WatchlistEntry>> {
  WatchlistNotifier() : super([]) {
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    final box = Hive.box<WatchlistEntry>('watchlist');
    final entries = box.values.toList();
    entries.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    state = entries;
  }

  Future<void> addToWatchlist(WatchlistEntry entry) async {
    final box = Hive.box<WatchlistEntry>('watchlist');
    await box.put(entry.animeId, entry);
    await _loadWatchlist();
  }

  Future<void> removeFromWatchlist(String animeId) async {
    final box = Hive.box<WatchlistEntry>('watchlist');
    await box.delete(animeId);
    await _loadWatchlist();
  }

  bool isInWatchlist(String animeId) {
    return state.any((entry) => entry.animeId == animeId);
  }
}
