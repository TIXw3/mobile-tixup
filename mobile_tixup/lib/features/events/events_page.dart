import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/events_viewmodel.dart';

class TelaPesquisa extends StatelessWidget {
  const TelaPesquisa({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsViewModel(),
      child: const _TelaPesquisaBody(),
    );
  }
}

class _TelaPesquisaBody extends StatelessWidget {
  const _TelaPesquisaBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EventsViewModel>(context);
    final laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
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
                    controller: viewModel.searchController,
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
                    // TODO: Implement category filter in ViewModel if needed
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
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.errorMessage != null
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
                                  viewModel.errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontFamily: 'sans-serif',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: viewModel.fetchEvents,
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
                      : viewModel.filteredEvents.isEmpty
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
                              itemCount: viewModel.filteredEvents.length,
                              itemBuilder: (context, index) {
                                return _buildEventoCard(viewModel.filteredEvents[index], context);
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventoCard(Map<String, dynamic> evento, BuildContext context) {
    final laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
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
}