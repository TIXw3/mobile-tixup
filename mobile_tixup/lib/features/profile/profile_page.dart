import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/features/favorites/favorites_page.dart';
import 'package:mobile_tixup/features/profile/pages/account_page.dart';
import 'package:mobile_tixup/features/profile/pages/balance_page.dart';
import 'package:mobile_tixup/features/profile/pages/following_page.dart';
import 'package:mobile_tixup/features/profile/pages/orders_page.dart';
import 'package:mobile_tixup/features/profile/pages/payments_page.dart';
import 'package:mobile_tixup/features/profile/pages/sellTickets_page.dart';
import 'package:mobile_tixup/features/profile/pages/student_id_page.dart';
import 'package:mobile_tixup/features/profile/pages/suporte_page.dart';
import 'package:mobile_tixup/features/profile/pages/tickets_page.dart';
import 'package:mobile_tixup/features/profile/pages/tutorial_page.dart';
import 'package:mobile_tixup/features/profile/pages/editprofile_page.dart';
import '../../../../models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _deleteAccount() async {
    // Aqui você pode adicionar lógica de exclusão no backend
    // Por enquanto, ele só faz logout como exemplo
    await authService.signOut();
    if (mounted) {
      Navigator.of(context).pop(); // Fecha o diálogo
    }
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir Conta"),
          content: const Text(
            "Tem certeza de que deseja excluir sua conta? Essa ação é irreversível.",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final user = userProvider.user;
  final nome = user?.nome ?? 'Nome';
  final email = user?.email ?? 'email@email.com';
  final telefone = user?.telefone ?? 'Sem telefone';
  final endereco = user?.endereco ?? 'Sem endereço';
  final imagemPerfil = user?.imagemPerfil ?? '';

  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 248, 247, 245),
    body: SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(nome, email, telefone, endereco, imagemPerfil),
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

  Widget _buildHeader(
    String nome,
    String email,
    String telefone,
    String endereco,
    String foto,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color.fromARGB(255, 240, 228, 211),
            backgroundImage: NetworkImage(foto),
          ),
          const SizedBox(height: 10),
          Text(
            nome,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'sans-serif',
            ),
          ),
          Text(
            email,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: 'sans-serif',
            ),
          ),
          if (telefone.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              telefone,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: 'sans-serif',
              ),
            ),
          ],
          if (endereco.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              endereco,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontFamily: 'sans-serif',
              ),
            ),
          ],
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Compartilhar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 248, 247, 245),
                  foregroundColor: const Color.fromARGB(255, 249, 115, 22),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 249, 115, 22),
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(fontSize: 14, fontFamily: 'sans-serif'),
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
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 249, 115, 22),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 249, 115, 22),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
            },
            child: _buildStatItem('10', 'Favoritos'),
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
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: const Color.fromARGB(255, 249, 115, 22),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 249, 115, 22),
            fontFamily: 'sans-serif',
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'sans-serif',
          ),
        ),
      ],
    );
  }

  Widget _buildMainMenu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 249, 115, 22)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildMenuItem('Meus Ingressos', Icons.confirmation_number_outlined,
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeusIngressos()),
            );
          }),
          _buildMenuItem('Carteirinhas', Icons.card_membership_outlined,
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentIdScreen()),
            );
          }),
          _buildMenuItem('Minha Conta', Icons.person_outline, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeuPerfil()),
            );
          }),
          _buildMenuItem('Tutorial', Icons.help_outline, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaTutorial()),
            );
          }),
          _buildMenuItem('Meus Cartões', Icons.credit_card_outlined,
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentsPage()),
            );
          }),
          _buildMenuItem('Vender Ingressos', Icons.sell_outlined, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaVenderIngresso()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSupportMenu() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 249, 115, 22),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildMenuItem('Suporte', Icons.headset_mic_outlined, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaDeSuporte()),
            );
          }),
          _buildMenuItem('Sair', Icons.exit_to_app_outlined, onTap: logout),
          _buildMenuItem('Excluir Conta', Icons.delete_outline,
              color: Colors.red, onTap: _confirmDeleteAccount),
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
      leading: Icon(
        icon,
        color: color ?? const Color.fromARGB(255, 249, 115, 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: 16,
          fontFamily: 'sans-serif',
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color.fromARGB(255, 249, 115, 22),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSocialLinks() {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Center(
      child: _buildSocialButton(
        'Instagram',
        Icons.camera_alt_outlined,
        'instagram://user?username=tixup_oficial',
        'https://www.instagram.com/tixup_oficial/',
      ),
    ),
  );
}
   Future<void> _launchURL(String appUrl, String webUrl) async {
    final Uri appUri = Uri.parse(appUrl);
    final Uri webUri = Uri.parse(webUrl);

    try {
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(webUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      await launchUrl(webUri, mode: LaunchMode.platformDefault);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao abrir $appUrl: $e')));
    }
  }

 Widget _buildSocialButton(
  String title,
  IconData icon,
  String appUrl,
  String webUrl,
) {
  return OutlinedButton.icon(
    onPressed: () => _launchURL(appUrl, webUrl),
    icon: Icon(icon, color: const Color.fromARGB(255, 249, 115, 22)),
    label: Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 249, 115, 22),
        fontFamily: 'sans-serif',
        fontSize: 14,
      ),
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      side: const BorderSide(
        color: Color.fromARGB(255, 249, 115, 22),
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ),
  );
 }
}