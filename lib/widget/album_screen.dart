import 'package:flutter/material.dart';
import 'package:albumlog/model/album.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle save album action
          print("Saving album: ${album.name}");
        },
        child: const Icon(Icons.save),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(child: Image.asset('none')),
            Text('Album: ${album.name}'),
            Text('Artist: ${album.artist}'),
            Text('ID: ${album.id}'),
          ],
        ),
      ),
    );
  }
}
