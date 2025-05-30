import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaPesquisa extends StatefulWidget {
  const TelaPesquisa({super.key});

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final TextEditingController _searchController = TextEditingController();
  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
  List<Map<String, dynamic>> _todosEventos = [];
  List<Map<String, dynamic>> _eventosFiltrados = [];
  bool _carregando = true;
  String? _erroMensagem;

  @override
  void initState() {
    super.initState();
    _carregarEventosDoSupabase();
    _searchController.addListener(_filtrarEventos);
  }

  Future<void> _carregarEventosDoSupabase() async {
    setState(() {
      _carregando = true;
      _erroMensagem = null;
    });
    try {
      final data = await Supabase.instance.client
          .from('eventos')
          .select()
          .order('data', ascending: true);

      _todosEventos = data.map((json) {
        return {
          'id': json['id'],
          'nome': json['nome'],
          'data': json['data'],
          'local': json['local'],
          'descricao': json['descricao'],
          'preco': json['preco'],
          'imagem': json['imagem'],
          'categoria': json['categoria'],
        };
      }).toList();

      setState(() {
        _eventosFiltrados = _todosEventos;
        _carregando = false;
      });
    } on PostgrestException catch (e) {
      setState(() {
        _erroMensagem = 'Erro ao carregar eventos: ${e.message}';
        _carregando = false;
      });
      print('Erro PostgREST: ${e.message}');
    } catch (e) {
      setState(() {
        _erroMensagem = 'Ocorreu um erro inesperado: $e';
        _carregando = false;
      });
      print('Erro inesperado: $e');
    }
  }

  void _filtrarEventos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _eventosFiltrados = _todosEventos.where((evento) {
        final nome = (evento['nome'] ?? '').toString().toLowerCase();
        final local = (evento['local'] ?? '').toString().toLowerCase();
        final descricao = (evento['descricao'] ?? '').toString().toLowerCase();
        final categoria = (evento['categoria'] ?? '').toString().toLowerCase();
        final data = (evento['data'] ?? '').toString().toLowerCase();

        return nome.contains(query) ||
            local.contains(query) ||
            descricao.contains(query) ||
            categoria.contains(query) ||
            data.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildEventoCard(Map<String, dynamic> evento) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventScreen(
              eventoData: evento,
              initialTicketCounts: {'Pista': 0, 'VIP': 0, 'Camarote': 0},
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 205,
              height: 145,
              decoration: BoxDecoration(
                border: Border.all(color: laranjaPrincipal, width: 2),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                image: evento['imagem'] != null && evento['imagem'].isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(evento['imagem']),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: evento['imagem'] == null || evento['imagem'].isEmpty
                  ? Center(
                      child: Text(
                        'Evento',
                        style: TextStyle(
                          color: laranjaPrincipal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sans-serif',
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['data'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(118, 0, 0, 0),
                      fontFamily: 'sans-serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento['nome'] ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'sans-serif',
                      color: laranjaPrincipal,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    evento['local'] ?? '',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      fontFamily: 'sans-serif',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Busque eventos por nome, local ou data...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'sans-serif',
                      ),
                      prefixIcon: Icon(Icons.search, color: laranjaPrincipal),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
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
                        borderSide: BorderSide(
                          color: laranjaPrincipal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: laranjaPrincipal),
                  onSelected: (String result) {
                    print('Categoria selecionada: $result');
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Todos',
                      child: Text('Todas as Categorias'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Show',
                      child: Text('Show'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Festas',
                      child: Text('Festas'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Baladas',
                      child: Text('Baladas'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Boates',
                      child: Text('Boates'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Diversos',
                      child: Text('Diversos'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _carregando
                  ? const Center(child: CircularProgressIndicator())
                  : _erroMensagem != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 80,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  _erroMensagem!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: 'sans-serif',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: _carregarEventosDoSupabase,
                                  icon: Icon(Icons.refresh),
                                  label: Text('Tentar Novamente'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: laranjaPrincipal,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _eventosFiltrados.isEmpty
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