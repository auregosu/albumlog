import 'package:flutter/material.dart';
import 'package:albumlog/widget/album_list_view.dart';
import 'package:albumlog/state/saved_albums.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: savedAlbums,
      builder: (context, _) {
        final albums = savedAlbums.albums;
        final scheme = Theme.of(context).colorScheme;

        if (albums.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 64,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'No saved albums yet',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 40,
                  color: scheme.onSurfaceVariant,
                ),
                Text(
                  "${albums.length}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(child: AlbumListView(albumList: albums)),
          ],
        );
      },
    );
  }
}
