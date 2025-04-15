import 'package:flutter/material.dart';

class TelaPesquisa extends StatefulWidget {
  const TelaPesquisa({Key? key}) : super(key: key);

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final TextEditingController _searchController = TextEditingController();

  // Novo laranja (orange-500)
  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  final List<Map<String, String>> _todosEventos = [
    {'data': '06 de Abr', 'nome': 'FILIN', 'local': 'Maringá/PR'},
    {'data': '12 de Abr', 'nome': 'FOLKS', 'local': 'Maringá/PR'},
    {'data': '19 de Abr', 'nome': 'DOUHA', 'local': 'Maringá/PR'},
    {'data': '27 de Abr', 'nome': 'CASA DA VÓ', 'local': 'Maringá/PR'},
    {'data': '04 de Mai', 'nome': 'BUTIQUIM', 'local': 'Maringá/PR'},
    {'data': '11 de Mai', 'nome': 'NEW YORK', 'local': 'Maringá/PR'},
    {'data': '18 de Mai', 'nome': 'BLACK NIGHT', 'local': 'Maringá/PR'},
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
      _eventosFiltrados =
          _todosEventos
              .where(
                (evento) =>
                    evento['nome']!.toLowerCase().contains(query) ||
                    evento['local']!.toLowerCase().contains(query),
              )
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
            child: Text(
              'Evento',
              style: TextStyle(
                color: laranjaPrincipal,
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
                  style: TextStyle(
                    fontSize: 14,
                    color: laranjaPrincipal,
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
                Row(
                  children: [
                    Text(
                      '${evento['local']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    Text(
                      ' • DJ Ensek',
                      style: TextStyle(
                        fontSize: 14,
                        color: laranjaPrincipal,
                        fontFamily: 'sans-serif',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: laranjaPrincipal,
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
                prefixIcon: Icon(Icons.search, color: laranjaPrincipal),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: laranjaPrincipal),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranjaPrincipal),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: laranjaPrincipal, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child:
                  _eventosFiltrados.isEmpty
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 80,
                            color: laranjaPrincipal,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Nenhum resultado encontrado',
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
