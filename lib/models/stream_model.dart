name=lib/models/stream_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'stream_model.g.dart';

@JsonSerializable()
class StreamServer {
  final String type;
  final String dataId;
  final String serverId;
  final String serverName;

  StreamServer({
    required this.type,
    required this.dataId,
    required this.serverId,
    required this.serverName,
  });

  factory StreamServer.fromJson(Map<String, dynamic> json) =>
      _$StreamServerFromJson(json);
  Map<String, dynamic> toJson() => _$StreamServerToJson(this);
}

@JsonSerializable()
class StreamTrack {
  final String file;
  final String label;
  final String kind;
  final bool? isDefault;

  StreamTrack({
    required this.file,
    required this.label,
    required this.kind,
    this.isDefault,
  });

  factory StreamTrack.fromJson(Map<String, dynamic> json) =>
      _$StreamTrackFromJson(json);
  Map<String, dynamic> toJson() => _$StreamTrackToJson(this);
}

@JsonSerializable()
class StreamLink {
  final String id;
  final String type;
  final String file;
  final List<StreamTrack> tracks;
  final IntroOutro? intro;
  final IntroOutro? outro;
  final String server;

  StreamLink({
    required this.id,
    required this.type,
    required this.file,
    required this.tracks,
    this.intro,
    this.outro,
    required this.server,
  });

  factory StreamLink.fromJson(Map<String, dynamic> json) =>
      _$StreamLinkFromJson(json);
  Map<String, dynamic> toJson() => _$StreamLinkToJson(this);
}

@JsonSerializable()
class IntroOutro {
  final int start;
  final int end;

  IntroOutro({required this.start, required this.end});

  factory IntroOutro.fromJson(Map<String, dynamic> json) =>
      _$IntroOutroFromJson(json);
  Map<String, dynamic> toJson() => _$IntroOutroToJson(this);
}

@JsonSerializable()
class StreamResponse {
  final bool success;
  final StreamResponseData results;

  StreamResponse({required this.success, required this.results});

  factory StreamResponse.fromJson(Map<String, dynamic> json) =>
      _$StreamResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StreamResponseToJson(this);
}

@JsonSerializable()
class StreamResponseData {
  @JsonKey(name: 'streamingLink')
  final StreamLink streamingLink;
  final List<StreamServer> servers;

  StreamResponseData({
    required this.streamingLink,
    required this.servers,
  });

  factory StreamResponseData.fromJson(Map<String, dynamic> json) =>
      _$StreamResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$StreamResponseDataToJson(this);
}
