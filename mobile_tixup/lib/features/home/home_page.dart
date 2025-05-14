import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/profile/profile_page.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
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

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                          'Salve, nome!',
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
            child: Column(
              children: [
                content(context),
                const SizedBox(height: 20),
                categories(context),
                const SizedBox(height: 20),
                eventsLikedByFriends(context),
                const SizedBox(height: 20),
                recommendedEventsCarousel(context),
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

  Widget content(BuildContext context) {
    List<String> imagePaths = [
      'lib/assets/images/party1.jpg',
      'lib/assets/images/party2.jpg',
      'lib/assets/images/party3.jpg',
      'lib/assets/images/party4.jpg',
      'lib/assets/images/party5.jpg',
    ];

    return CarouselSlider(
      items:
          imagePaths.map((path) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EventScreen(
                          ticketCounts: {
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
                      color: const Color.fromARGB(
                        255,
                        249,
                        115,
                        22,
                      ).withOpacity(0.9),
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
                      child: Image.asset(
                        path,
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
                    const Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        'Evento XXI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sans-serif',
                        ),
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

  Widget categories(BuildContext context) {
    return CarouselSlider(
      items:
          ["Show", "Festas", "Baladas", "Boates", "Diversos"].map((i) {
            return Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 247, 245),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color.fromARGB(255, 249, 115, 22), // Laranja
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  i,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 249, 115, 22),
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

  Widget eventsLikedByFriends(BuildContext context) {
    List<String> imagePaths = [
      'lib/assets/images/party6.jpg',
      'lib/assets/images/party3.jpg',
      'lib/assets/images/party2.jpg',
      'lib/assets/images/party4.jpg',
      'lib/assets/images/party1.jpg',
    ];

    return CarouselSlider(
      items: List.generate(imagePaths.length, (i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => EventScreen(
                      ticketCounts: {
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
                      color: const Color.fromARGB(255, 249, 115, 22), // Laranja
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePaths[i],
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
                        "Nome do Evento $i",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 249, 115, 22),
                          fontFamily: 'sans-serif',
                        ),
                      ),
                      const Text(
                        "25/04 - Londrina/PR",
                        style: TextStyle(
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
      }),
      options: CarouselOptions(
        height: 270,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }

  Widget recommendedEventsCarousel(BuildContext context) {
    List<String> imagePaths = [
      'lib/assets/images/party6.jpg',
      'lib/assets/images/party3.jpg',
      'lib/assets/images/party2.jpg',
      'lib/assets/images/party1.jpg',
      'lib/assets/images/party4.jpg',
    ];

    return CarouselSlider(
      items: List.generate(imagePaths.length, (i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => EventScreen(
                      ticketCounts: {
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
                      color: const Color.fromARGB(255, 249, 115, 22), // Laranja
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePaths[i],
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
                        "Nome do Evento $i",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 249, 115, 22),
                          fontFamily: 'sans-serif',
                        ),
                      ),
                      const Text(
                        "25/04 - Londrina/PR",
                        style: TextStyle(
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
      }),
      options: CarouselOptions(
        height: 270,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
    );
  }

  Widget goToEventsPage(BuildContext context) {
    return const AnimatedEventButton();
  }
}
