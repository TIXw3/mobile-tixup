import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mobile_tixup/features/events/InformationPurchase_page.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required Map<String, int> ticketCounts});

  @override
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  Map<String, int> ticketCounts = {
    "Meia MASCULINO": 0,
    "Meia FEMININO": 0,
    "Inteira MASCULINO": 0,
    "Inteira FEMININO": 0,
  };

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('event_favorite') ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('event_favorite', isFavorite);
    });
  }

  void increment(String type) {
    setState(() {
      ticketCounts[type] = (ticketCounts[type] ?? 0) + 1;
    });
  }

  void decrement(String type) {
    setState(() {
      if ((ticketCounts[type] ?? 0) > 0) {
        ticketCounts[type] = ticketCounts[type]! - 1;
      }
    });
  }

  void shareEvent() {
    final message = '''
Confira este evento incrível!

Nome: Nome do evento
Data: Sáb, Mar 15 • 19:00h
Local: R. Unicesu, 999 – Jardim Mar, Maringá/PR

Compre já seu ingresso pelo app Tixup!
''';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationPurchasePage()),
            );
          },
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
                          child: Image.asset(
                            'lib/assets/images/party1.jpg',
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
                      onPressed: shareEvent,
                      icon: const Icon(Icons.share_outlined),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
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
                  const Text(
                    'Nome do evento',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sáb, Mar 15 • 19:00h\nR. Unicesu, 999 – Jardim Mar, Maringá/PR – 87727-878',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 44),
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  sectionText(
                    'Proibido entrada de menores de 18 anos.\nAbertura dos portões às 20h\n\nObrigatório a apresentação de documento com foto na entrada (não aceitamos e-documento).\n\nEsse evento poderá ser gravado e compartilhado nas redes sociais, ao adquirir o ingresso você concorda com o uso da sua imagem gratuitamente.',
                  ),
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
                  ...ticketCounts.keys.map((type) => ticketTile(type)),
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

  Widget ticketTile(String type) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color.fromARGB(255, 249, 115, 22), width: 0.5),
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
                  Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('R\$50,00'),
                  const Text(
                    '+ taxa de serviço de R\$5,00',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => decrement(type),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${ticketCounts[type]}'),
                IconButton(
                  onPressed: () => increment(type),
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
