import 'package:flutter/material.dart';
import 'package:albumlog/model/album.dart';
import 'package:albumlog/widget/album_screen.dart';
import 'package:albumlog/state/saved_albums.dart';

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({super.key, required this.album});

  final Album album;
  @override
  Widget build(BuildContext context) {
    final cover = albumCoverImage(album);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => AlbumScreen(album: album),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: cover == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.album,
                        size: 48,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: cover,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.album, size: 100),
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    album.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    album.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
