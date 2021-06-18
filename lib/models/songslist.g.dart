// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songslist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsListAdapter extends TypeAdapter<SongsList> {
  @override
  final int typeId = 0;

  @override
  SongsList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsList()..songslist = (fields[0] as List).cast<SongInfo>();
  }

  @override
  void write(BinaryWriter writer, SongsList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songslist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
