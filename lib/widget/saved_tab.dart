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
        if (albums.isEmpty) {
          return const Center(child: Text('No saved albums yet'));
        }
        return AlbumListView(albumList: albums);
      },
    );
  }
}
