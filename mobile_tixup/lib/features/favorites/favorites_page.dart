import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/auth/services/favorites_service.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/favorites_viewmodel.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesViewModel(),
      child: const _FavoriteScreenBody(),
    );
  }
}

class _FavoriteScreenBody extends StatelessWidget {
  const _FavoriteScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FavoritesViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
        elevation: 0,
        centerTitle: true,
        title: const Icon(
          Icons.confirmation_number,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 249, 115, 22),
              ),
            )
          : viewModel.favoriteEvents.isEmpty
              ? _buildEmptyState(context)
              : _buildFavoritesList(context, viewModel),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Favoritos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Suas curtidas irão aparecer aqui!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 249, 115, 22),
                        width: 2,
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          color: Color.fromARGB(255, 249, 115, 22),
                          size: 60,
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Você ainda não curtiu nenhum evento',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaPesquisa(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Explorar eventos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'sans-serif',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesList(BuildContext context, FavoritesViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meus Favoritos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'sans-serif',
                ),
              ),
              Text(
                '${viewModel.favoriteEvents.length} evento${viewModel.favoriteEvents.length != 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 249, 115, 22),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'sans-serif',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            color: const Color.fromARGB(255, 249, 115, 22),
            onRefresh: viewModel.loadFavorites,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: viewModel.favoriteEvents.length,
              itemBuilder: (context, index) {
                final evento = viewModel.favoriteEvents[index];
                return _buildEventCard(context, evento, viewModel);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> evento, FavoritesViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventScreen(
                eventoData: evento,
                initialTicketCounts: const {'Pista': 0, 'VIP': 0},
              ),
            ),
          );
          viewModel.loadFavorites();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: evento['imagem'] != null && evento['imagem'].isNotEmpty
                      ? Image.network(
                          evento['imagem'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'lib/assets/images/party6.jpg',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: IconButton(
                    onPressed: () => viewModel.removeFromFavorites(evento['id'].toString(), context),
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['nome'] ?? 'Nome do evento',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color.fromARGB(255, 249, 115, 22),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          evento['data'] ?? 'Data não informada',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color.fromARGB(255, 249, 115, 22),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          evento['local'] ?? 'Local não informado',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: 'sans-serif',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
}