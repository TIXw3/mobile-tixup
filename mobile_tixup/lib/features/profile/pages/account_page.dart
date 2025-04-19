import 'package:flutter/material.dart';

class MeuPerfil extends StatelessWidget {
  MeuPerfil({Key? key}) : super(key: key);

  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  // Simulação de dados do usuário
  final Map<String, String> usuario = {
    'nome': 'Lucas Gabriel',
    'email': 'email@email.com',
    'telefone': '(44) 99999-0000',
    'data': '12/08/2000',
    'endereco': 'Rua X, Jardim Y, 89898993',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: laranjaPrincipal,
        centerTitle: true,
        title: const Text(
          'Meu Perfil',
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
                  backgroundColor: laranjaPrincipal.withOpacity(0.1),
                  child: Icon(Icons.person, size: 50, color: laranjaPrincipal),
                ),
                const SizedBox(height: 10),
                Text(
                  usuario['nome']!,
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
            _buildInfoRow(Icons.email, 'Email', usuario['email']!),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.phone, 'Telefone', usuario['telefone']!),
            const SizedBox(height: 15),
            _buildInfoRow(
              Icons.calendar_month,
              'Data de Nascimento',
              usuario['data']!,
            ),
            const SizedBox(height: 15),
            _buildInfoRow(Icons.house, 'Endereço', usuario['endereco']!),
            const SizedBox(height: 15),
            _buildActionButton(Icons.history, 'Histórico de Compras', () {}),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: laranjaPrincipal),
        const SizedBox(width: 10),
        Column(
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
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'sans-serif',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDestructive ? Colors.red.withOpacity(0.05) : Colors.white,
          border: Border.all(
            color: isDestructive ? Colors.red : laranjaPrincipal,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : laranjaPrincipal),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'sans-serif',
                fontWeight: FontWeight.w500,
                color: isDestructive ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
