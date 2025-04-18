import 'package:flutter/material.dart';

class MeusIngressos extends StatefulWidget {
  const MeusIngressos({Key? key}) : super(key: key);

  @override
  State<MeusIngressos> createState() => _MeusIngressosState();
}

class _MeusIngressosState extends State<MeusIngressos> {
  // Laranja principal usado na tela anterior
  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  // Lista fictícia de ingressos
  final List<Map<String, String>> _meusIngressos = [
    {
      'data': '06 de Abr',
      'evento': 'FILIN',
      'local': 'Maringá/PR',
      'qrcode': '1234567890',
    },
    {
      'data': '12 de Abr',
      'evento': 'FOLKS',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '15 de Abr',
      'evento': 'NEW YORK',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '18 de Out',
      'evento': 'FILIN',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '12 de Jan',
      'evento': 'ExpoInga',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '2 de Jul',
      'evento': 'BUTIQUIM',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
  ];

  Widget _buildIngressoCard(Map<String, String> ingresso) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: laranjaPrincipal),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: laranjaPrincipal, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Icon(Icons.qr_code_2, size: 40, color: laranjaPrincipal),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingresso['data']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: laranjaPrincipal,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ingresso['evento']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'sans-serif',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ingresso['local']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: laranjaPrincipal,
        centerTitle: true,
        title: const Text(
          'Meus Ingressos',
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
        child:
            _meusIngressos.isEmpty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_busy, size: 80, color: laranjaPrincipal),
                    const SizedBox(height: 20),
                    Text(
                      'Você ainda não comprou nenhum ingresso',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: laranjaPrincipal,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                )
                : ListView.builder(
                  itemCount: _meusIngressos.length,
                  itemBuilder: (context, index) {
                    return _buildIngressoCard(_meusIngressos[index]);
                  },
                ),
      ),
    );
  }
}
