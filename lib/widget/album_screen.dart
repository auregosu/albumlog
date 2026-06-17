import 'package:flutter/material.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/service/discogs_api.dart';
import 'package:albumlog/state/saved_albums.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key, required this.album});

  final Album album;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late Album _album;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _album = widget.album;
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final detailed = await fetchAlbumDetails(widget.album);
      setState(() {
        _album = detailed;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cover = albumCoverImage(_album);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final meta = [_album.format, _album.year].whereType<String>().join(' - ');

    return Scaffold(
      appBar: AppBar(title: Text('Record')),
      floatingActionButton: ListenableBuilder(
        listenable: savedAlbums,
        builder: (context, _) {
          final saved = savedAlbums.contains(_album);
          return FloatingActionButton(
            onPressed: () => savedAlbums.toggle(_album),
            child: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Album image
          if (cover != null)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: cover,
                  errorBuilder: (context, error, stack) => const SizedBox(),
                ),
              ),
            ),
          const SizedBox(height: 24),
          // Album title
          Text(
            _album.name,
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Album artist
          Text(
            _album.artist,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          // Album release and format
          if (meta.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              meta,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 24),
          // Album description
          if (_loading) const Center(child: CircularProgressIndicator()),
          if (_album.description != null && _album.description!.isNotEmpty) ...[
            Text(
              'About',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(_album.description!, style: textTheme.bodyMedium),
            const SizedBox(height: 24),
          ],
          // Album tracklist
          if (_album.tracklist != null) ...[
            Text(
              'Tracklist',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int i = 0; i < _album.tracklist!.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${i + 1}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _album.tracklist![i],
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
