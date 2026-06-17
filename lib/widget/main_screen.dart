import 'package:flutter/material.dart';
import 'package:albumlog/widget/search_tab.dart';
import 'package:albumlog/widget/saved_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.startingIndex});

  final int? startingIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.startingIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.bookmark), label: 'Saved'),
        ],
      ),
      body:
        IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            SearchTab(),
            SavedTab(),
          ],
        ),
    );
  }
}
