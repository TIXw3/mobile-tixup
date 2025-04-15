import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/features/profile/pages/balance_page.dart';
import 'package:mobile_tixup/features/profile/pages/following_page.dart';
import 'package:mobile_tixup/features/profile/pages/orders_page.dart';
import 'package:mobile_tixup/features/profile/pages/payments_page.dart';
import 'package:mobile_tixup/features/profile/pages/suporte_page.dart';
import 'package:mobile_tixup/features/profile/pages/tutorial_page.dart';
import '../../../../models/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final email = userProvider.user?.email ?? 'email@email.com';

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(email),
            _buildStatistics(),
            _buildMainMenu(),
            _buildSocialLinks(),
            _buildSupportMenu(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String email) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 240, 228, 211),
            backgroundImage: NetworkImage(''),
          ),
          const SizedBox(height: 10),
          const Text(
            'Lucas Gabriel',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            email,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Compartilhar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(111, 231, 87, 47),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('10', 'Favoritos'),
          _buildVerticalDivider(),
          _buildVerticalDivider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SeguindoPage()),
              );
            },
            child: _buildStatItem('10', 'Seguindo'),
          ),
          _buildVerticalDivider(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SaldoPage()),
              );
            },
            child: _buildStatItem('R\$0,00', 'Saldo'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.deepOrange.withOpacity(0.3),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMainMenu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 249, 115, 22),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildMenuItem('Meus Ingressos', Icons.confirmation_number_outlined),
          _buildMenuItem('Carteirinhas', Icons.card_membership_outlined),
          _buildMenuItem(
            'Pedidos',
            Icons.shopping_bag_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersScreen()),
              );
            },
          ),
          _buildMenuItem('Minha Conta', Icons.person_outline),
          _buildMenuItem('Meu Endereço', Icons.location_on_outlined),
          _buildMenuItem(
            'Tutorial',
            Icons.help_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaTutorial()),
              );
            },
          ),
          _buildMenuItem(
            'Meus Cartões',
            Icons.credit_card_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentsPage()),
              );
            },
          ),
          _buildMenuItem('Vender Ingressos', Icons.sell_outlined),
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton('Instagram', Icons.camera_alt_outlined),
          const SizedBox(width: 10),
          _buildSocialButton('YouTube', Icons.play_arrow_outlined),
        ],
      ),
    );
  }

  Widget _buildSupportMenu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 249, 115, 22),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            'Suporte',
            Icons.headset_mic_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaDeSuporte()),
              );
            },
          ),
          _buildMenuItem('Sair', Icons.exit_to_app_outlined, onTap: logout),
          _buildMenuItem(
            'Excluir Conta',
            Icons.delete_outline,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon, {
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Color.fromARGB(255, 249, 115, 22)),
      title: Text(
        title,
        style: TextStyle(color: color ?? Colors.black, fontSize: 16),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color.fromARGB(255, 249, 115, 22),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSocialButton(String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 249, 115, 22),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
