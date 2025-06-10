import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/tickets_viewmodel.dart';

class MeusIngressos extends StatelessWidget {
  const MeusIngressos({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketsViewModel(),
      child: const _MeusIngressosBody(),
    );
  }
}

class _MeusIngressosBody extends StatelessWidget {
  const _MeusIngressosBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TicketsViewModel>(context);
    final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
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
        child: viewModel.meusIngressos.isEmpty
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
                itemCount: viewModel.meusIngressos.length,
                itemBuilder: (context, index) {
                  return _buildIngressoCard(viewModel.meusIngressos[index], laranjaPrincipal);
                },
              ),
      ),
    );
  }

  Widget _buildIngressoCard(Map<String, String> ingresso, Color laranjaPrincipal) {
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
}
