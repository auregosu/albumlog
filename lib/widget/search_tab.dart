import 'package:flutter/material.dart';
import 'package:albumlog/widget/album_search_bar.dart';
import 'package:albumlog/widget/album_list_view.dart';
import 'package:albumlog/model/album.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _textController = TextEditingController();

  List<Album> exampleAlbumList = [
    Album(name: "Album 1", artist: "Artist 1", id: "1"),
    Album(name: "Album 2", artist: "Artist 2", id: "2"),
    Album(name: "Album 3", artist: "Artist 3", id: "3"),
    Album(name: "Album 4", artist: "Artist 4", id: "4"),
    Album(name: "Album 5", artist: "Artist 5", id: "5"),
    Album(name: "Album 6", artist: "Artist 6", id: "6"),
    Album(name: "Album 7", artist: "Artist 7", id: "7"),
    Album(name: "Album 8", artist: "Artist 8", id: "8"),
    Album(name: "Album 9", artist: "Artist 9", id: "9"),
    Album(name: "Album 10", artist: "Artist 10", id: "10"),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AlbumSearchBar(controller: _textController),
          Expanded(child: AlbumListView(albumList: exampleAlbumList)),
        ],
      ),
    );
  }
}
