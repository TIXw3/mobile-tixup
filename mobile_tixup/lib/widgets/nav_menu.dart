import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/favorites/favorites_page.dart';
import 'package:mobile_tixup/features/profile/profile_page.dart';
import 'package:mobile_tixup/features/home/home_page.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  final List<Widget> _screens = [
    HomeScreen(),
    TelaPesquisa(),
    ShopScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 8,
          indicatorColor: laranjaPrincipal.withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (states) => TextStyle(
              fontSize: 12,
              fontWeight:
                  states.contains(MaterialState.selected)
                      ? FontWeight.bold
                      : FontWeight.w500,
              fontFamily: 'sans-serif',
              color:
                  states.contains(MaterialState.selected)
                      ? laranjaPrincipal
                      : Colors.black,
            ),
          ),
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
            (states) => IconThemeData(
              color:
                  states.contains(MaterialState.selected)
                      ? laranjaPrincipal
                      : Colors.black54,
              size: 24,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          animationDuration: const Duration(milliseconds: 300),
          destinations: const [
            NavigationDestination(
              icon: Icon(Ionicons.home_outline),
              label: 'Início',
              selectedIcon: Icon(Ionicons.home),
            ),
            NavigationDestination(
              icon: Icon(Ionicons.pricetag_outline),
              label: 'Eventos',
              selectedIcon: Icon(Ionicons.pricetag),
            ),
            NavigationDestination(
              icon: Icon(Ionicons.wallet_outline),
              label: 'Loja',
              selectedIcon: Icon(Ionicons.wallet),
            ),
            NavigationDestination(
              icon: Icon(Ionicons.heart_outline),
              label: 'Favoritos',
              selectedIcon: Icon(Ionicons.heart),
            ),
            NavigationDestination(
              icon: Icon(Ionicons.person_outline),
              label: 'Perfil',
              selectedIcon: Icon(Ionicons.person),
            ),
          ],
        ),
      ),
    );
  }
}
