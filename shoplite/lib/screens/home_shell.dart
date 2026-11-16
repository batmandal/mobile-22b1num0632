import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'catalog_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Доод NavigationBar бүхий үндсэн бүтэц. IndexedStack нь таб солиход
/// дэлгэц бүрийн төлөвийг (хайлтын текст, scroll) хадгална.
/// Бонус 1: өргөн ≥ 900 үед доод NavigationBar-ын оронд зүүн талд NavigationRail.
class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final body = IndexedStack(
      index: _index,
      children: [
        const HomeScreen(),
        const CatalogScreen(),
        const CartScreen(),
        ProfileScreen(
          darkMode: widget.darkMode,
          onDarkModeChanged: widget.onDarkModeChanged,
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        return Scaffold(
          body: wide
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _index,
                      onDestinationSelected: _select,
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text('Нүүр'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.grid_view_outlined),
                          selectedIcon: Icon(Icons.grid_view),
                          label: Text('Каталог'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.shopping_cart_outlined),
                          selectedIcon: Icon(Icons.shopping_cart),
                          label: Text('Сагс'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_outline),
                          selectedIcon: Icon(Icons.person),
                          label: Text('Профайл'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: body),
                  ],
                )
              : body,
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: _select,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Нүүр',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: 'Каталог',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.shopping_cart_outlined),
                      selectedIcon: Icon(Icons.shopping_cart),
                      label: 'Сагс',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Профайл',
                    ),
                  ],
                ),
        );
      },
    );
  }
}
