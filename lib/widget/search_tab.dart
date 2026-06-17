import 'package:flutter/material.dart';
import 'package:albumlog/widget/album_search_bar.dart';
import 'package:albumlog/widget/album_list_view.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/service/discogs_api.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _textController = TextEditingController();

  List<Album> _albums = [];
  bool _loading = false;
  String? _error;

  Future<void> _runSearch(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = await searchAlbums(query);
      setState(() => _albums = results);
    } catch (e) {
      setState(() => _error = 'ERROR: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AlbumSearchBar(controller: _textController, onSearch: _runSearch),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          Expanded(child: AlbumListView(albumList: _albums)),
        ],
      ),
    );
  }
}
