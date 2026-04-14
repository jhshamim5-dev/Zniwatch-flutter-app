name=lib/models/watch_history_model.g.dart
part of 'watch_history_model.dart';

class WatchHistoryEntryAdapter extends TypeAdapter<WatchHistoryEntry> {
  @override
  final int typeId = 0;

  @override
  WatchHistoryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchHistoryEntry(
      animeId: fields[0] as String,
      animeTitle: fields[1] as String,
      animeCover: fields[2] as String,
      episode: fields[3] as int,
      episodeId: fields[4] as String,
      timestamp: fields[5] as int,
      duration: fields[6] as int,
      audioType: fields[7] as String,
      updatedAt: fields[8] as int,
      totalEpisodes: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WatchHistoryEntry obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.animeId)
      ..writeByte(1)
      ..write(obj.animeTitle)
      ..writeByte(2)
      ..write(obj.animeCover)
      ..writeByte(3)
      ..write(obj.episode)
      ..writeByte(4)
      ..write(obj.episodeId)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.audioType)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.totalEpisodes);
  }
}

class WatchlistEntryAdapter extends TypeAdapter<WatchlistEntry> {
  @override
  final int typeId = 1;

  @override
  WatchlistEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlistEntry(
      animeId: fields[0] as String,
      animeTitle: fields[1] as String,
      animeCover: fields[2] as String,
      totalEpisodes: fields[3] as int,
      addedAt: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WatchlistEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.animeId)
      ..writeByte(1)
      ..write(obj.animeTitle)
      ..writeByte(2)
      ..write(obj.animeCover)
      ..writeByte(3)
      ..write(obj.totalEpisodes)
      ..writeByte(4)
      ..write(obj.addedAt);
  }
}
