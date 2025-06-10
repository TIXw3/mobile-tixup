import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/following_viewmodel.dart';

class SeguindoPage extends StatelessWidget {
  const SeguindoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FollowingViewModel(),
      child: const _SeguindoPageBody(),
    );
  }
}

class _SeguindoPageBody extends StatelessWidget {
  const _SeguindoPageBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FollowingViewModel>(context);
    final Color orange500 = const Color.fromARGB(255, 249, 115, 22);
    final organizadoresOrdenados = viewModel.organizadoresOrdenados;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: orange500,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Seguindo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'sans-serif',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Organizações Seguidas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: orange500,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Os organizadores que você segue irão aparecer aqui!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  Text(
                    'Ordenar por',
                    style: TextStyle(
                      fontSize: 18,
                      color: orange500,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: viewModel.selectedOrder,
                    items: <String>[
                      'A-Z',
                      'Z-A',
                      'Mais Recentes',
                      'Mais Antigos',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        viewModel.setOrder(newValue);
                      }
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                    iconEnabledColor: orange500,
                    dropdownColor: Colors.white,
                    underline: Container(height: 2, color: orange500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: organizadoresOrdenados.length,
                itemBuilder: (context, index) {
                  final org = organizadoresOrdenados[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: orange500, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          org['nome']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: orange500,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          org['descricao']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}