import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Loja'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Perfil'),
        ],
      ),
    );
  }
}
