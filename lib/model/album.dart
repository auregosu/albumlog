class Album {
  final String id;
  final String name;
  final String artist;
  final String? year;
  final String? format;
  final String? coverUrl;

  final String? description;
  final List<String>? tracklist;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    this.year,
    this.format,
    this.coverUrl,
    this.description,
    this.tracklist,
  });

  factory Album.fromSearchJson(Map<String, dynamic> json) {
    final fullTitle = json['title'] as String? ?? '';
    String artist = '';
    String name = fullTitle;
    final separator = fullTitle.indexOf(' - ');
    if (separator != -1) {
      artist = fullTitle.substring(0, separator);
      name = fullTitle.substring(separator + 3);
    }

    return Album(
      id: json['id'].toString(),
      name: name,
      artist: artist,
      year: json['year']?.toString(),
      format: _recordType(json['format']),
      coverUrl: json['cover_image'] as String?,
    );
  }

  static String? _recordType(dynamic rawFormat) {
    if (rawFormat is! List || rawFormat.isEmpty) return null;
    final formats = rawFormat.map((f) => f.toString()).toList();

    const knownTypes = ['LP', 'EP', 'Single', 'Mini-Album', 'Maxi-Single'];
    for (final type in knownTypes) {
      if (formats.contains(type)) return type;
    }
    return formats.join(', '); // fallback, e.g. "CD, Album"
  }

  Album copyWithDetails({String? description, List<String>? tracklist}) {
    return Album(
      id: id,
      name: name,
      artist: artist,
      year: year,
      format: format,
      coverUrl: coverUrl,
      description: description ?? this.description,
      tracklist: tracklist ?? this.tracklist,
    );
  }

  // JSON serialization for saving to local storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'artist': artist,
    'year': year,
    'format': format,
    'coverUrl': coverUrl,
    'description': description,
    'tracklist': tracklist,
  };

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      year: json['year'] as String?,
      format: json['format'] as String?,
      coverUrl: json['coverUrl'] as String?,
      description: json['description'] as String?,
      tracklist: (json['tracklist'] as List<dynamic>?)
          ?.map((t) => t as String)
          .toList(),
    );
  }
}
