import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:albumlog/model/album.dart';

// API key
const String _token = 'ynxAhaaaqRvYteoKYKoZItEXnECBZOSvYVguYLDR';

// User-agent required by Discogs
const Map<String, String> _headers = {
  'User-Agent': 'AlbumLog/0.1',
  'Authorization': 'Discogs token=$_token',
};

// Search masters (not specific releases)
Future<List<Album>> searchAlbums(String query) async {
  final url = Uri.https('api.discogs.com', '/database/search', {
    'q': query,
    'type': 'master',
    'per_page': '20',
  });

  final response = await http.get(url, headers: _headers);
  if (response.statusCode != 200) {
    throw Exception('Search failed (${response.statusCode})');
  }

  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final results = body['results'] as List<dynamic>;

  return results
      .map((item) => Album.fromSearchJson(item as Map<String, dynamic>))
      .toList();
}

// Fill in tracklist and description for one album
Future<Album> fetchAlbumDetails(Album album) async {
  final url = Uri.https('api.discogs.com', '/masters/${album.id}');

  final response = await http.get(url, headers: _headers);
  if (response.statusCode != 200) {
    throw Exception('Loading details failed (${response.statusCode})');
  }

  final body = jsonDecode(response.body) as Map<String, dynamic>;

  final rawTracks = body['tracklist'] as List<dynamic>? ?? [];
  final tracklist = rawTracks
      .map((t) => (t as Map<String, dynamic>)['title'] as String? ?? '')
      .where((title) => title.isNotEmpty)
      .toList();

  final description = body['notes'] as String?;

  return album.copyWithDetails(description: description, tracklist: tracklist);
}

// Download an album cover and return its local file name
Future<String?> downloadCover(
  String albumId,
  String coverUrl,
  String coverDir,
) async {
  if (albumId.isEmpty || coverUrl.isEmpty || coverDir.isEmpty) return null;
  try {
    final response = await http.get(Uri.parse(coverUrl), headers: _headers);
    if (response.statusCode != 200) return null;

    final fileName = 'cover_$albumId.jpg';
    await File('$coverDir/$fileName').writeAsBytes(response.bodyBytes);
    return fileName;
  } catch (_) {
    return null;
  }
}
