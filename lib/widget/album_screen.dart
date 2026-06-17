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
    return Scaffold(
      appBar: AppBar(title: Text('Album')),
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
          if (_album.coverUrl != null)
            Image.network(
              _album.coverUrl!,
              errorBuilder: (context, error, stack) => const SizedBox(),
            ),
          const SizedBox(height: 16),
          Text(_album.name, style: Theme.of(context).textTheme.headlineLarge),
          Text(_album.artist, style: Theme.of(context).textTheme.titleMedium),
          if (_album.format != null) Text('Format: ${_album.format}'),
          if (_album.year != null) Text('Released: ${_album.year}'),
          const SizedBox(height: 16),
          if (_loading) const Center(child: CircularProgressIndicator()),
          if (_album.description != null && _album.description!.isNotEmpty) ...[
            Text('About', style: Theme.of(context).textTheme.titleMedium),
            Text(_album.description!),
            const SizedBox(height: 16),
          ],
          if (_album.tracklist != null) ...[
            Text('Tracklist', style: Theme.of(context).textTheme.titleMedium),
            for (int i = 0; i < _album.tracklist!.length; i++)
              Text('${i+1}. ${_album.tracklist![i]}'),
          ],
        ],
      ),
    );
  }
}
