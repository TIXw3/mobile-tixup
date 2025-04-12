import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
            SizedBox(height: 10), // espaço topo
            content(context), //carrossel (Eventos)
            SizedBox(height: 20), // espaçamento widgets

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
            categories(context), // carrossel (Categorias)
            SizedBox(height: 1), // espaçamento resto

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(alignment: Alignment.centerLeft),
            ),
            eventsLikedByFriends(
              context,
            ), // Carrossel de eventos curtidos por amigos
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
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                path,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
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
          [1, 2, 3, 4, 5].map((i) {
            return Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 249, 115, 22),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text("Categoria $i", style: TextStyle(fontSize: 30)),
              ),
            );
          }).toList(),
      options: CarouselOptions(
        height: 75,
        enableInfiniteScroll: true, //ficar trocando
        autoPlay: true,
        viewportFraction: 0.5, // autoplay p melhor xp
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
      items:
          List.generate(imagePaths.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinha os textos à esquerda
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
                  SizedBox(height: 12), // Espaçamento entre o card e os textos
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nome do Evento $i", // Novo título
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "25/04 - Londrina/PR", // Novo título
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ), // Pequeno espaçamento entre os textos
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
            );
          }).toList(),
      options: CarouselOptions(
        height: 270, // Ajustado para acomodar melhor os textos
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
