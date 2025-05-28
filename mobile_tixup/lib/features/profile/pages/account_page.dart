import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeuPerfil extends StatefulWidget {
  const MeuPerfil({super.key});

  @override
  State<MeuPerfil> createState() => _MeuPerfilState();
}

class _MeuPerfilState extends State<MeuPerfil> {
  final Color laranja = const Color.fromARGB(255, 249, 115, 22);

  String nome = '';
  String email = '';
  String telefone = '';
  String endereco = '';
  String? caminhoImagem;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? '';
      email = prefs.getString('email') ?? '';
      telefone = prefs.getString('numero') ?? '';
      endereco = prefs.getString('endereco') ?? '';
      caminhoImagem = prefs.getString('imagemPerfil');
    });
  }

  @override
  Widget build(BuildContext context) {
    File? imageFile = caminhoImagem != null ? File(caminhoImagem!) : null;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: laranja,
        centerTitle: true,
        title: const Text(
          'Minha Conta',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'sans-serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: laranja.withOpacity(0.1),
                  backgroundImage: imageFile != null ? FileImage(imageFile) : null,
                  child: imageFile == null
                      ? Icon(Icons.person, size: 50, color: laranja)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans-serif',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildInfoRow(Icons.email, 'E-mail', email),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.phone, 'Telefone', telefone),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.house, 'Endereço', endereco),
            const SizedBox(height: 15),
            _buildActionButton(Icons.history, 'Histórico de Compras', () {
              // Implementar funcionalidade aqui
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: laranja),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'sans-serif',
                  color: Colors.grey,
                ),
              ),
              Text(
                valor.isNotEmpty ? valor : '-',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'sans-serif',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: laranja,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'sans-serif',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
