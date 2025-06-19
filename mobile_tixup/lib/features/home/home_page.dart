import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/profile/profile_page.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/home_viewmodel.dart';
import 'package:mobile_tixup/models/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final laranjaPrincipal = viewModel.laranjaPrincipal;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 248, 247, 245),
            elevation: 0,
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 150,
            collapsedHeight: 70,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double percentage =
                    (constraints.maxHeight - kToolbarHeight) /
                    (160 - kToolbarHeight);
                final double textSize = 24 * percentage.clamp(0.8, 1.1);
                final double avatarSize = 46 * percentage.clamp(0.8, 1.1);

                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 16,
                    right: 16,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: avatarSize,
                            height: avatarSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Color.fromARGB(
                                255,
                                240,
                                228,
                                211,
                              ),
                              backgroundImage: NetworkImage(
                                'https://img.freepik.com/fotos-gratis/jovem-barbudo-com-camisa-listrada_273609-5677.jpg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Salve, ${Provider.of<UserProvider>(context).user?.nome.split(' ').first ?? 'nome'}!',
                          style: TextStyle(
                            fontFamily: 'sans-serif',
                            fontSize: textSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaPesquisa(),
                    ),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopScreen()),
                  );
                },
                icon: const Icon(CupertinoIcons.cart_fill, color: Colors.black),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child:
                viewModel.isLoading
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
                    : Column(
                      children: [
                        _content(context, viewModel),
                        const SizedBox(height: 20),
                        categories(context, laranjaPrincipal),
                        const SizedBox(height: 20),
                        _eventsLikedByFriends(
                          context,
                          viewModel,
                          laranjaPrincipal,
                        ),
                        const SizedBox(height: 20),
                        _recommendedEventsCarousel(
                          context,
                          viewModel,
                          laranjaPrincipal,
                        ),
                        const SizedBox(height: 20),
                        goToEventsPage(context),
                        const SizedBox(height: 20),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget _content(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.highlightedEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider(
      items:
          viewModel.highlightedEvents.map((evento) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EventScreen(
                          eventoData: evento,
                          initialTicketCounts: {
                            "Meia MASCULINO": 0,
                            "Meia FEMININO": 0,
                            "Inteira MASCULINO": 0,
                            "Inteira FEMININO": 0,
                          },
                        ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: viewModel.laranjaPrincipal.withOpacity(0.9),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          evento['imagem'] != null &&
                                  evento['imagem'].isNotEmpty
                              ? Image.network(
                                evento['imagem'],
                                width: double.infinity,
                                height: 270,
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                'lib/assets/images/party6.jpg',
                                width: double.infinity,
                                height: 270,
                                fit: BoxFit.cover,
                              ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evento['nome'] ?? 'Evento Desconhecido',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                          Text(
                            evento['data'] != null
                                ? _formatDate(evento['data'])
                                : '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
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
          }).toList(),
      options: CarouselOptions(
        height: 280,
        autoPlay: true,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        viewportFraction: 0.88,
        autoPlayCurve: Curves.easeInOut,
      ),
    );
  }

  Widget categories(BuildContext context, Color laranjaPrincipal) {
    return CarouselSlider(
      items:
          [
            "Shows",
            "Festivais",
            "Eventos Esportivos",
            "Festas",
            "Baladas",
            "Teatro & Comédia",
          ].map((i) {
            return Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 247, 245),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: laranjaPrincipal, width: 1.5),
              ),
              child: Center(
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 20,
                    color: laranjaPrincipal,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
      options: CarouselOptions(
        height: 45,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: 0.3,
      ),
    );
  }

  Widget _eventsLikedByFriends(
    BuildContext context,
    HomeViewModel viewModel,
    Color laranjaPrincipal,
  ) {
    if (viewModel.friendsLikedEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Curtidos por amigos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[850],
              fontFamily: 'sans-serif',
            ),
          ),
        ),
        CarouselSlider(
          items:
              viewModel.friendsLikedEvents.map((evento) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EventScreen(
                              eventoData: evento,
                              initialTicketCounts: {
                                "Meia MASCULINO": 0,
                                "Meia FEMININO": 0,
                                "Inteira MASCULINO": 0,
                                "Inteira FEMININO": 0,
                              },
                            ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: laranjaPrincipal,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                evento['imagem'] != null &&
                                        evento['imagem'].isNotEmpty
                                    ? Image.network(
                                      evento['imagem'],
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                    : Image.asset(
                                      'lib/assets/images/party6.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                evento['nome'] ?? 'Evento Desconhecido',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: laranjaPrincipal,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                              Text(
                                '${_formatDate(evento['data'] ?? '')} - ${evento['local'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Curtido por Fulano e +3",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[930],
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
              }).toList(),
          options: CarouselOptions(
            height: 270,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _recommendedEventsCarousel(
    BuildContext context,
    HomeViewModel viewModel,
    Color laranjaPrincipal,
  ) {
    if (viewModel.recommendedEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Eventos recomendados',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey[850],
              fontFamily: 'sans-serif',
            ),
          ),
        ),
        CarouselSlider(
          items:
              viewModel.recommendedEvents.map((evento) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EventScreen(
                              eventoData: evento,
                              initialTicketCounts: {
                                "Meia MASCULINO": 0,
                                "Meia FEMININO": 0,
                                "Inteira MASCULINO": 0,
                                "Inteira FEMININO": 0,
                              },
                            ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: laranjaPrincipal,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                evento['imagem'] != null &&
                                        evento['imagem'].isNotEmpty
                                    ? Image.network(
                                      evento['imagem'],
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    )
                                    : Image.asset(
                                      'lib/assets/images/party6.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                evento['nome'] ?? 'Evento Desconhecido',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: laranjaPrincipal,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                              Text(
                                '${_formatDate(evento['data'] ?? '')} - ${evento['local'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Curtido por Fulano e +3",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[930],
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
              }).toList(),
          options: CarouselOptions(
            height: 270,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }

  Widget goToEventsPage(BuildContext context) {
    return const AnimatedEventButton();
  }

  String _formatDate(String date) {
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        return '${parts[2]}/${parts[1]}/${parts[0]}';
      }
      return date;
    } catch (e) {
      return date;
    }
  }
}

class AnimatedEventButton extends StatefulWidget {
  const AnimatedEventButton({super.key});

  @override
  State<AnimatedEventButton> createState() => _AnimatedEventButtonState();
}

class _AnimatedEventButtonState extends State<AnimatedEventButton> {
  bool isAnimating = false;
  double arrowPosition = 0;

  void _onPressed(BuildContext context) async {
    setState(() {
      isAnimating = true;
      arrowPosition = 250;
    });

    await Future.delayed(const Duration(milliseconds: 330));

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaPesquisa()),
    );

    if (mounted) {
      setState(() {
        isAnimating = false;
        arrowPosition = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 55,
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: isAnimating ? null : () => _onPressed(context),
            style: ElevatedButton.styleFrom(
              elevation: 4,
              backgroundColor: const Color(0xFFF97316),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
              shadowColor: const Color(0xFFFFA260),
            ),
            child: const Center(child: Text('Ver eventos')),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            left: arrowPosition,
            top: 15,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: isAnimating ? 1 : 0,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
