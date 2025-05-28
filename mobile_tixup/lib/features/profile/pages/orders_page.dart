import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final Color orange500 = const Color.fromARGB(255, 249, 115, 22);

  final List<Map<String, String>> _todosEventos = [
    {'data': '06 de Abr', 'nome': 'FILIN', 'local': 'Maringá/PR', 'valor': ' • 97,55'},
    {'data': '12 de Abr', 'nome': 'FOLKS', 'local': 'Maringá/PR', 'valor': ' • 55,90'},
    {'data': '19 de Abr', 'nome': 'DOUHA', 'local': 'Maringá/PR', 'valor': ' • 49,90'},
    {'data': '27 de Abr', 'nome': 'CASA DA VÓ', 'local': 'Maringá/PR', 'valor': ' • 37,50'},
    {'data': '04 de Mai', 'nome': 'BUTIQUIM', 'local': 'Maringá/PR', 'valor': ' • 99,90'},
    {'data': '11 de Mai', 'nome': 'NEW YORK', 'local': 'Maringá/PR', 'valor': ' • 29,90'},
    {'data': '18 de Mai', 'nome': 'BLACK NIGHT', 'local': 'Maringá/PR', 'valor': ' • 89,90'},
  ];

  List<Map<String, String>> _eventosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _eventosFiltrados = _todosEventos;
    _searchController.addListener(_filtrarEventos);
  }

  void _filtrarEventos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _eventosFiltrados = _todosEventos.where((evento) {
        return evento['nome']!.toLowerCase().contains(query) ||
            evento['local']!.toLowerCase().contains(query) ||
            evento['valor']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildEventoCard(Map<String, String> evento) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: orange500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.event_available, size: 36, color: orange500),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(
                        evento['data']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'sans-serif',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento['nome']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: orange500,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        evento['local']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'sans-serif',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          color: orange500.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'R\$${evento['valor']!.replaceAll("•", "").trim()}',
                          style: TextStyle(
                            color: orange500,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: _searchController,
              style: const TextStyle(
                fontFamily: 'sans-serif',
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar compras...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'sans-serif',
                ),
                prefixIcon: Icon(Icons.search, color: orange500),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _eventosFiltrados.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_outlined, size: 80, color: orange500),
                        const SizedBox(height: 20),
                        Text(
                          'Nenhum resultado encontrado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: orange500,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _eventosFiltrados.length,
                      itemBuilder: (context, index) {
                        return _buildEventoCard(_eventosFiltrados[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
