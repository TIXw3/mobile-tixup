import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/student_id_viewmodel.dart';

class StudentIdScreen extends StatelessWidget {
  final Color backgroundColor = const Color.fromARGB(255, 248, 247, 245);
  final Color laranjaPrincipal = const Color(0xFFF97316);

  const StudentIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StudentIdViewModel(),
      child: const _StudentIdBody(),
    );
  }
}

class _StudentIdBody extends StatelessWidget {
  const _StudentIdBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudentIdViewModel>(context);
    final Color backgroundColor = const Color.fromARGB(255, 248, 247, 245);
    final Color laranjaPrincipal = const Color(0xFFF97316);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: laranjaPrincipal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Minhas Carteirinhas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'sans-serif',
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: viewModel.carteirinhas.length,
          itemBuilder: (context, index) {
            final item = viewModel.carteirinhas[index];
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
                      // Implementar edição usando viewModel.editarCarteirinha
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
          // Implementar adição usando viewModel.adicionarCarteirinha
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
