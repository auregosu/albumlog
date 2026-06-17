import 'package:flutter/material.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/widget/album_screen.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({super.key, required this.albumList});

  final List<Album> albumList;

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.albumList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.album),
          title: Text('Album ${widget.albumList[index].name}'),
          subtitle: Text(widget.albumList[index].artist),
          onTap: () {
            // Handle album tap, e.g., navigate to album details
            print("Tapped on ${widget.albumList[index].name}");
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => AlbumScreen(album: widget.albumList[index]),
                ),
              );
          },
        );
      },
    );
  }
}
