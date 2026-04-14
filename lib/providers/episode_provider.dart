name=lib/providers/episode_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/episode_model.dart';
import '../services/api_service.dart';

final episodesProvider =
    FutureProvider.family<EpisodesResponse, String>((ref, animeId) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchEpisodes(animeId);
});
