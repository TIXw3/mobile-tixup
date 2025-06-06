import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mobile_tixup/features/events/InformationPurchase_page.dart';
import 'package:mobile_tixup/features/auth/services/favorites_service.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/event_detail_viewmodel.dart';

class EventScreen extends StatelessWidget {
  final Map<String, dynamic> eventoData;
  final Map<String, int> initialTicketCounts;

  const EventScreen({
    super.key,
    required this.eventoData,
    required this.initialTicketCounts,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventDetailViewModel(eventoData: eventoData, initialTicketCounts: initialTicketCounts),
      child: const _EventScreenBody(),
    );
  }
}

class _EventScreenBody extends StatelessWidget {
  const _EventScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EventDetailViewModel>(context);
    final evento = viewModel.eventoData;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 249, 115, 22),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: viewModel.hasSelectedTickets() && evento != null && viewModel.ticketCounts.isNotEmpty
              ? () async {
                  await viewModel.savePurchaseData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationPurchasePage(),
                    ),
                  );
                }
              : null,
          child: const Text(
            'Finalizar compra!',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                          child: evento['imagem'] != null && evento['imagem'].isNotEmpty
                              ? Image.network(
                                  evento['imagem'],
                                  height: 250,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'lib/assets/images/party6.jpg',
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: 60,
                    child: IconButton(
                      onPressed: viewModel.shareEvent,
                      icon: const Icon(Icons.share_outlined),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: IconButton(
                      onPressed: viewModel.toggleFavorite,
                      icon: Icon(
                        viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: viewModel.isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      iconSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['nome'] ?? 'Nome do evento',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${evento['data'] ?? ''} • ${evento['local'] ?? ''}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 44),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  sectionText(evento['descricao'] ?? 'Sem descrição disponível.'),
                  const SizedBox(height: 44),
                  const Text(
                    'Políticas de cancelamento',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  sectionText(
                    'A solicitação de cancelamento pode ser feita em até 7 dias corridos após a compra, desde que seja feita antes de 48 horas do início do evento.',
                  ),
                  const SizedBox(height: 44),
                  const Text(
                    'Ingressos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...viewModel.ticketCounts.keys.map((type) => ticketTile(type, viewModel)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(text, style: const TextStyle(fontSize: 14));
  }

  Widget ticketTile(String type, EventDetailViewModel viewModel) {
    final Map<String, double> ticketPrices = {
      'Pista': 55.0,
      'VIP': 85.0,
      'Camarote': 100.0,
    };
    final double price = ticketPrices[type] ?? 55.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color.fromARGB(255, 249, 115, 22),
          width: 0.5,
        ),
      ),
      elevation: 2,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('R\$${price.toStringAsFixed(2).replaceAll('.', ',')}'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => viewModel.decrement(type),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${viewModel.ticketCounts[type]}'),
                IconButton(
                  onPressed: () => viewModel.increment(type),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}