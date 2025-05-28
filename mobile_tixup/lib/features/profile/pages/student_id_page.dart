import 'package:flutter/material.dart';

class StudentIdScreen extends StatelessWidget {
  final Color backgroundColor = const Color.fromARGB(255, 248, 247, 245);
  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  final List<Map<String, String>> carteirinhas = [
    {
      'nome': 'Lucas B Ovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 12/2025',
      'instituicao': 'Unicesumar',
    },
    {
      'nome': 'Lucas Bovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 08/2025',
      'instituicao': 'Santa Cruz',
    },
    {
      'nome': 'Lucas de Freitas',
      'tipo': 'Convidade',
      'validade': 'Validade: 03/2026',
      'instituicao': 'ExpoInga',
    },
    {
      'nome': 'Lucas B Ovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 12/2025',
      'instituicao': 'Unicesumar',
    },
    {
      'nome': 'Lucas Bovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 08/2025',
      'instituicao': 'Santa Cruz',
    },
  ];

  StudentIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Minhas Carteirinhas',
          style: TextStyle(
            color: laranjaPrincipal,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: laranjaPrincipal),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: carteirinhas.length,
          itemBuilder: (context, index) {
            final item = carteirinhas[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(color: laranjaPrincipal.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: laranjaPrincipal.withOpacity(0.1),
                    child: Icon(Icons.credit_card, color: laranjaPrincipal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['nome']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['tipo']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: laranjaPrincipal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['instituicao']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          item['validade']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: laranjaPrincipal),
                    onPressed: () {
                      // logica p editar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Editar ${item['nome']}')),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: laranjaPrincipal,
        onPressed: () {
          // tela de cadastrar carteirinha
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Adicionar nova carteirinha')),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Adicionar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
