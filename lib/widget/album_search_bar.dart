import 'package:flutter/material.dart';

class AlbumSearchBar extends StatelessWidget {
  const AlbumSearchBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search album',
          icon: Icon(Icons.search),
        ),
        onSubmitted: (value) {
          // Search album logic after entering search term
          print("Searching for: $value");
        },
      ),
    );
  }
}