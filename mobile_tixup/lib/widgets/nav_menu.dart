import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobile_tixup/features/profile/profile_page.dart';
import 'package:mobile_tixup/features/home/home_page.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0; //mostra a pagina que esta (inicial)

  final List<Widget> _screens = [
    HomeScreen(), // home
    Scaffold(body: Center(child: Text("Eventos"))), // placeholder eventos
    ShopScreen(), // placeholder loja
    Scaffold(body: Center(child: Text("Favoritos"))), // placeholder favoritos
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    // quando clicar troca
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // mostra a tela clicada
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped, // atualiza selecionado
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Início'),
          NavigationDestination(icon: Icon(Iconsax.medal), label: 'Eventos'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Loja'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Perfil'),
        ],
      ),
    );
  }
}
