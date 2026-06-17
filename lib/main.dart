import 'package:flutter/material.dart';
import 'package:albumlog/widget/main_screen.dart';
import 'package:albumlog/state/saved_albums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await savedAlbums.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Applog',
      theme: ThemeData(colorScheme: ColorScheme.dark()),
      home: const MainScreen(startingIndex: 0),
    );
  }
}
