import 'package:flutter/foundation.dart';
import 'package:albumlog/model/album.dart';

class SavedAlbums extends ChangeNotifier {
  final List<Album> _albums = [];

  List<Album> get albums => List.unmodifiable(_albums);

  bool contains(Album album) => _albums.any((a) => a.id == album.id);

  void toggle(Album album) {
    if (contains(album)) {
      _albums.removeWhere((a) => a.id == album.id);
    } else {
      _albums.add(album);
    }
    notifyListeners();
  }
}

// Global state for saved albums
final savedAlbums = SavedAlbums();