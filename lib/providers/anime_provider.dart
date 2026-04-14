name=lib/providers/anime_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final topAiringProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchTopAiring();
});

final mostPopularProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchMostPopular();
});

final completedProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchCompleted();
});

final mostFavoriteProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchMostFavorite();
});

final topUpcomingProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchTopUpcoming();
});

final latestEpisodeProvider = FutureProvider<List<AnimeModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchLatestEpisode();
});

final searchAnimeProvider =
    FutureProvider.family<List<AnimeModel>, String>((ref, keyword) async {
  if (keyword.isEmpty) return [];
  final apiService = ref.watch(apiServiceProvider);
  return apiService.searchAnime(keyword);
});

final animeDetailsProvider =
    FutureProvider.family<AnimeModel, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchAnimeInfo(id);
});
