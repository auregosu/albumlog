import 'package:flutter/material.dart';
import 'package:albumlog/widget/album_list_view.dart';
import 'package:albumlog/model/album.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  List<Album> exampleAlbumList = [
    Album(name: "Saved Album 1", artist: "Artist 1", id: "1"),
    Album(name: "Saved Album 2", artist: "Artist 2", id: "2"),
    Album(name: "Saved Album 3", artist: "Artist 3", id: "3"),
    Album(name: "Saved Album 4", artist: "Artist 4", id: "4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("My saved albums"),
          Expanded(child: AlbumListView(albumList: exampleAlbumList)),
        ],
      ),
    );
  }
}
