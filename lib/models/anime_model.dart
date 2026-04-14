name=lib/models/anime_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'anime_model.g.dart';

@JsonSerializable()
class AnimeModel {
  final String id;
  final String title;
  final String? japaneseTitle;
  final String? description;
  final String posterUrl;
  final String? bannerUrl;
  final int? episodes;
  final double? averageScore;
  final String status;
  final List<String> genres;
  final int? duration;
  final String? format;
  final int? subCount;
  final int? dubCount;
  final NextAiringEpisode? nextAiringEpisode;

  AnimeModel({
    required this.id,
    required this.title,
    this.japaneseTitle,
    this.description,
    required this.posterUrl,
    this.bannerUrl,
    this.episodes,
    this.averageScore,
    required this.status,
    required this.genres,
    this.duration,
    this.format,
    this.subCount,
    this.dubCount,
    this.nextAiringEpisode,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnimeModelToJson(this);
}

@JsonSerializable()
class NextAiringEpisode {
  final int episode;
  final int airingAt;
  final int timeUntilAiring;

  NextAiringEpisode({
    required this.episode,
    required this.airingAt,
    required this.timeUntilAiring,
  });

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) =>
      _$NextAiringEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$NextAiringEpisodeToJson(this);
}

@JsonSerializable()
class Character {
  final String id;
  final String name;
  final String imageUrl;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class AnimeDetailsModel extends AnimeModel {
  final String? nativeTitle;
  final List<Character>? characters;
  final List<Studio>? studios;
  final String? trailerYoutubeId;
  final int? idMal;
  final int? meanScore;
  final int? popularity;

  AnimeDetailsModel({
    required String id,
    required String title,
    String? japaneseTitle,
    String? description,
    required String posterUrl,
    String? bannerUrl,
    int? episodes,
    double? averageScore,
    required String status,
    required List<String> genres,
    int? duration,
    String? format,
    int? subCount,
    int? dubCount,
    NextAiringEpisode? nextAiringEpisode,
    this.nativeTitle,
    this.characters,
    this.studios,
    this.trailerYoutubeId,
    this.idMal,
    this.meanScore,
    this.popularity,
  }) : super(
    id: id,
    title: title,
    japaneseTitle: japaneseTitle,
    description: description,
    posterUrl: posterUrl,
    bannerUrl: bannerUrl,
    episodes: episodes,
    averageScore: averageScore,
    status: status,
    genres: genres,
    duration: duration,
    format: format,
    subCount: subCount,
    dubCount: dubCount,
    nextAiringEpisode: nextAiringEpisode,
  );

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeDetailsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnimeDetailsModelToJson(this);
}

@JsonSerializable()
class Studio {
  final String name;

  Studio({required this.name});

  factory Studio.fromJson(Map<String, dynamic> json) =>
      _$StudioFromJson(json);
  Map<String, dynamic> toJson() => _$StudioToJson(this);
}
