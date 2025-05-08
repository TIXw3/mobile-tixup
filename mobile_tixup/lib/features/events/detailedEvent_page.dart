import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/InformationPurchase_page.dart'; 

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required Map<String, int> ticketCounts});

  @override
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  // Quantidade de ingressos por tipo
  Map<String, int> ticketCounts = {
    "Meia MASCULINO": 0,
    "Meia FEMININO": 0,
    "Inteira MASCULINO": 0,
    "Inteira FEMININO": 0,
  };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 249, 115, 22), // Laranja
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationPurchasePage(), 
              ),
            );
          },
          child: Text(
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
                    right: 15,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 60,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Detalhes do evento
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome do evento',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sáb, Mar 15 • 19:00h\nR. Unicesu, 999 – Jardim Mar, Maringá/PR – 87727-878',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 44),
                  Text(
                    'Descrição',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  sectionText(
                    'Proibido entrada de menores de 18 anos.\nAbertura dos portões às 20h\n\nObrigatório a apresentação de documento com foto na entrada (não aceitamos e-documento).\n\nEsse evento poderá ser gravado e compartilhado nas redes sociais, ao adquirir o ingresso você concorda com o uso da sua imagem gratuitamente.',
                  ),
                  SizedBox(height: 44),
                  Text(
                    'Políticas de cancelamento',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  sectionText(
                    'A solicitação de cancelamento pode ser feita em até 7 dias corridos após a compra, desde que seja feita antes de 48 horas do início do evento.',
                  ),
                  SizedBox(height: 44),
                  Text(
                    'Ingressos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...ticketCounts.keys.map((type) => ticketTile(type)),
                  SizedBox(height: 40), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(text, style: TextStyle(fontSize: 14));
  }

  Widget ticketTile(String type) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Color.fromARGB(255, 249, 115, 22), width: 0.5),
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
                  Text(type, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('R\$50,00'),
                  Text(
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
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text('${ticketCounts[type]}'),
                IconButton(
                  onPressed: () => increment(type),
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
