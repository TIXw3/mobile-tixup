import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/detailedEvent_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 247, 245),
        elevation: 0,
        title: Text('Salve, nome!'),
        actions: [
          IconButton(
            onPressed: () {
              // lógica para abrir busca
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // lógica para abrir carrinho
            },
            icon: Icon(Icons.shop_2),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            content(context),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categorias",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            categories(context),
            SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(alignment: Alignment.centerLeft),
            ),
            eventsLikedByFriends(context),
            SizedBox(height: 20),
            goToEventsPage(context),
            SizedBox(height: 20),
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
      items:
          imagePaths.map((path) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventScreen()),
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
      items:
          ["Show", "Festas", "Baladas", "Universitárias", "Diversos"].map((i) {
            return Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 249, 115, 22),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text("$i", style: TextStyle(fontSize: 30))),
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
              MaterialPageRoute(builder: (context) => const EventScreen()),
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
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome do Evento $i",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "25/04 - Londrina/PR",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Curtido por Fulano e +3 ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
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
    return Column(
      children: [
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            print("Botão pressionado!");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 249, 115, 22),
            padding: const EdgeInsets.symmetric(
              vertical: 13.0,
              horizontal: 130.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text(
            'Eventos',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
