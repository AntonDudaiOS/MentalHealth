import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_mental_health_app/core/models/app_tab.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final void Function(AppTab tab) onTabChanged;

  const MainScaffold({super.key, required this.navigationShell, required this.onTabChanged});

  static const tabTitles = [
    'Home',
    'Tests',
    'Techniques',
    'Relaxation',
  ];

  void _onItemTapped(int index) {
    final tab = AppTab.values[index];
    onTabChanged(tab);
    
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;
    final title = (selectedIndex >= 0 && selectedIndex < tabTitles.length)
        ? tabTitles[selectedIndex]
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF5F5F5),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement_outlined),
            activeIcon: Icon(Icons.self_improvement),
            label: 'Techniques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Relaxation',
          ),
        ],
      ),
    );
  }
}
