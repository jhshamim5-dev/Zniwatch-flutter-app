name=lib/providers/stream_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/stream_model.dart';
import '../services/api_service.dart';

final streamProvider = FutureProvider.family<StreamResponse, StreamParams>(
    (ref, params) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchStream(params.episodeId, params.server, params.type);
});

class StreamParams {
  final String episodeId;
  final String server;
  final String type;

  StreamParams({
    required this.episodeId,
    required this.server,
    required this.type,
  });
}
