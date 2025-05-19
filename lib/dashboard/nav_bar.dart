import 'package:flutter/material.dart';
import 'package:sectiontask/about_us/aboutus_screen.dart';

import '../favorite/favorite_screen.dart';
import '../profile/profile_page/profile_page.dart';
import '../qoute/quote_screen.dart';
import 'dashboard_screen.dart';

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
      body:
          [
            DashboardScreen(),
            QuoteScreen(),
            FavoriteScreen(),
            ProfilePage(),
            AboutusScreen(),
          ][_selectedIndex],

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "dashboard",
          ),
          NavigationDestination(icon: Icon(Icons.format_quote), label: "Quote"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "favourite"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(
            icon: Icon(Icons.contact_page),
            label: "aboutus",
          ),
        ],
      ),
    );
  }
}
