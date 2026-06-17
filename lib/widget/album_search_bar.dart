import 'package:flutter/material.dart';

class AlbumSearchBar extends StatelessWidget {
  const AlbumSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  final TextEditingController controller;
  final void Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search records',
          prefixIcon: Icon(Icons.search),
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}
