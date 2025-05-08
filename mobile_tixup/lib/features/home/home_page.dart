import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 247, 245),
        elevation: 0,
        title: const Text(
          'Salve, nome!',
          style: TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaPesquisa()),
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
            icon: const Icon(Icons.shop_2, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            content(context),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categorias",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ),
            ),
            categories(context),
            const SizedBox(height: 20),
            eventsLikedByFriends(context),
            const SizedBox(height: 20),
            goToEventsPage(context),
            const SizedBox(height: 20),
          ],
        ),
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
      items: imagePaths.map((path) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventScreen(
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              path,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
    );
  }

  Widget categories(BuildContext context) {
    return CarouselSlider(
      items: ["Show", "Festas", "Baladas", "Boates", "Diversos"].map((i) {
        return Container(
          width: MediaQuery.of(context).size.width / 2,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 249, 115, 22),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              i,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontFamily: 'sans-serif',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 75,
        enableInfiniteScroll: true,
        autoPlay: true,
        viewportFraction: 0.5,
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
                builder: (context) => EventScreen(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePaths[i],
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    fit: BoxFit.cover,
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
                          color: Colors.black,
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
                          color: Colors.grey[700],
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
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TelaPesquisa()),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color.fromARGB(255, 249, 115, 22), width: 2),
          backgroundColor: const Color.fromARGB(255, 249, 115, 22),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Evento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'sans-serif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
