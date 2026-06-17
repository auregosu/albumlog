import 'package:flutter/material.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/widget/album_screen.dart';

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: album.coverUrl != null
          ? Image.network(
              album.coverUrl!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => const Icon(Icons.album),
            )
          : const Icon(Icons.album),
      title: Text(album.name),
      subtitle: Text(album.artist),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => AlbumScreen(album: album),
          ),
        );
      },
    );
  }
}

class AlbumListView extends StatelessWidget {
  const AlbumListView({super.key, required this.albumList});

  final List<Album> albumList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: albumList.length,
      itemBuilder: (context, index) {
        return AlbumListTile(album: albumList[index]);
      },
    );
  }
}
