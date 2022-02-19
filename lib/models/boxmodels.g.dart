// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxmodels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongBoxModelAdapter extends TypeAdapter<SongBoxModel> {
  @override
  final int typeId = 32;

  @override
  SongBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongBoxModel(
      songTitle: fields[0] as String,
      songUrl: fields[2] as String,
      songArtists: fields[1] as String?,
      songId: fields[3] as int,
      albumArt: fields[4] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, SongBoxModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songTitle)
      ..writeByte(1)
      ..write(obj.songArtists)
      ..writeByte(2)
      ..write(obj.songUrl)
      ..writeByte(3)
      ..write(obj.songId)
      ..writeByte(4)
      ..write(obj.albumArt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
