import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/service/discogs_api.dart';

const String _storeKey = 'saved_albums';
String? _coverDir;

class SavedAlbums extends ChangeNotifier {
  final List<Album> _albums = [];

  List<Album> get albums => List.unmodifiable(_albums);

  bool contains(Album album) => _albums.any((a) => a.id == album.id);

  Future<void> load() async {
    final dir = await getApplicationDocumentsDirectory();
    _coverDir = dir.path;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _albums
        ..clear()
        ..addAll(list.map((e) => Album.fromJson(e as Map<String, dynamic>)));
    }
    notifyListeners();
  }

  Future<void> toggle(Album album) async {
    if (contains(album)) {
      final existing = _albums.firstWhere((a) => a.id == album.id);
      await _deleteCover(existing);
      _albums.removeWhere((a) => a.id == album.id);
    } else {
      await downloadCover(album.id, album.coverUrl!, _coverDir!);
      _albums.add(album);
    }
    notifyListeners();
    await _saveLocally();
  }

  // Preserve changes to sharedPreferences
  Future<void> _saveLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_albums.map((a) => a.toJson()).toList());
    await prefs.setString(_storeKey, raw);
  }

  Future<void> _deleteCover(Album album) async {
    if (_coverDir == null) return;
    try {
      final file = File('$_coverDir/cover_${album.id}.jpg');
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }
}

// Picks the image source for an album: downloaded file or original URL
ImageProvider? albumCoverImage(Album album) {
  String imagePath = "$_coverDir/cover_${album.id}.jpg";
  if (File(imagePath).existsSync()) {
    return FileImage(File(imagePath));
  }
  if (album.coverUrl != null && album.coverUrl!.isNotEmpty) {
    return NetworkImage(album.coverUrl!);
  }
  return null;
}

// Global state for saved albums
final savedAlbums = SavedAlbums();
