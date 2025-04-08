import 'package:flutter/material.dart';

class TelaPesquisa extends StatefulWidget {
  const TelaPesquisa({Key? key}) : super(key: key);

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _todosEventos = [
    {'data': '22 de Abr', 'nome': 'FILLIN', 'local': 'Maringá/PR'},
    {'data': '30 de Abr', 'nome': 'FOLKS', 'local': 'Maringá/PR'},
    {'data': '05 de Mai', 'nome': 'DOUHA', 'local': 'Maringá/PR'},
    {'data': '10 de Mai', 'nome': 'CASA DA VÓ', 'local': 'Maringá/PR'},
    {'data': '18 de Mai', 'nome': 'BUTIQUIM', 'local': 'Maringá/PR'},
    {'data': '25 de Mai', 'nome': 'NEW YORK', 'local': 'Maringá/PR'},
    {'data': '31 de Mai', 'nome': 'BLACK NIGHT', 'local': 'Maringá/PR'},
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
      _eventosFiltrados = _todosEventos
          .where((evento) =>
              evento['nome']!.toLowerCase().contains(query) ||
              evento['local']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildEventoCard(Map<String, String> evento) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange),
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
              border: Border.all(color: Colors.deepOrange, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: const Text(
              'Evento',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'sans-serif',
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento['data']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.deepOrange,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  evento['nome']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'sans-serif',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Maringá/PR • DJ Ensek',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepOrange,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          'Pesquisar',
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
            TextField(
              controller: _searchController,
              style: const TextStyle(
                fontFamily: 'sans-serif',
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar eventos...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'sans-serif',
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _eventosFiltrados.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search_off_outlined,
                            size: 80, color: Colors.deepOrange),
                        SizedBox(height: 20),
                        Text(
                          'Nenhum resultado encontrado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
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
