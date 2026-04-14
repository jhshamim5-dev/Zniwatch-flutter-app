name=lib/models/episode_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel {
  final String id;
  final int episodeNumber;
  final String? title;
  final String? japaneseTitle;
  final bool isFiller;

  EpisodeModel({
    required this.id,
    required this.episodeNumber,
    this.title,
    this.japaneseTitle,
    this.isFiller = false,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
}

@JsonSerializable()
class EpisodesResponse {
  final int totalEpisodes;
  final List<EpisodeModel> episodes;

  EpisodesResponse({
    required this.totalEpisodes,
    required this.episodes,
  });

  factory EpisodesResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodesResponseToJson(this);
}
