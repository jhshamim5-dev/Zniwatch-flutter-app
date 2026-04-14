name=lib/services/api_service.dart
import 'package:dio/dio.dart';
import '../models/anime_model.dart';
import '../models/episode_model.dart';
import '../models/stream_model.dart';
import '../theme/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConstants.apiBaseUrl,
              connectTimeout: const Duration(
                  milliseconds: AppConstants.requestTimeout),
              receiveTimeout: const Duration(
                  milliseconds: AppConstants.requestTimeout),
            ));

  Future<List<AnimeModel>> fetchTopAiring() async {
    try {
      final response = await _dio.get('/api/top-airing');
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> fetchMostPopular() async {
    try {
      final response = await _dio.get('/api/most-popular');
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> fetchCompleted() async {
    try {
      final response = await _dio.get('/api/completed');
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> fetchMostFavorite() async {
    try {
      final response = await _dio.get('/api/most-favorite');
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> fetchTopUpcoming() async {
    try {
      final response = await _dio.get('/api/top-upcoming');
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> fetchLatestEpisode() async {
    try {
      final response = await _dio.get('/api/');
      final data = response.data['results']['latestEpisode'] as List? ?? [];
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnimeModel>> searchAnime(String keyword) async {
    try {
      final response =
          await _dio.get('/api/search', queryParameters: {'keyword': keyword});
      final data = response.data['results']['data'] as List;
      return data.map((item) => AnimeModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<AnimeDetailsModel> fetchAnimeInfo(String id) async {
    try {
      final response = await _dio.get('/api/info', queryParameters: {'id': id});
      final data = response.data['results']['data'];
      return AnimeDetailsModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<EpisodesResponse> fetchEpisodes(String id) async {
    try {
      final response = await _dio.get('/api/episodes/$id');
      final data = response.data['results'];
      return EpisodesResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<StreamResponse> fetchStream(
      String episodeId, String server, String type) async {
    try {
      final response = await _dio.get('/api/stream', queryParameters: {
        'id': episodeId,
        'server': server,
        'type': type,
      });
      return StreamResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchDubbedAnime(int page) async {
    try {
      final response =
          await _dio.get('/api/dubbed-anime', queryParameters: {'page': page});
      return response.data['results'];
    } catch (e) {
      rethrow;
    }
  }
}
