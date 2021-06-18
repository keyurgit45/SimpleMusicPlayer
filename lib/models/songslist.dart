// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:hive/hive.dart';

part 'songslist.g.dart';

@HiveType(typeId: 0)
class SongsList extends HiveObject {
  @HiveField(0)
  late List<SongInfo> songslist;
}
