import 'package:first/about_us/about_us_screen.dart';
import 'package:first/dashboard/dashboard_screen.dart';
import 'package:first/profile/profile_page/profile_page.dart';
import 'package:first/quote/quote_screen.dart';
import 'package:flutter/material.dart';

import '../favorite/favorite_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [DashboardScreen(), QuoteScreen(),FavoriteScreen(), AboutUsScreen()][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.format_quote), label: "Quote"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorite"),
          NavigationDestination(icon: Icon(Icons.access_alarms), label: "About"),

        ],
      ),
    );
  }
}
