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
    return CarouselSlider(
      items:
          [1, 2, 3, 4, 5].map((i) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Color.fromARGB(206, 231, 87, 47),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text("Evento $i", style: TextStyle(fontSize: 40)),
              ),
            );
          }).toList(),
      options: CarouselOptions(height: 200),
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
                color: Color.fromARGB(206, 231, 87, 47),
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
    return CarouselSlider(
      items:
          [1, 2, 3, 4, 5].map((i) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinha os textos à esquerda
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180, // Define uma altura maior para os cards
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(206, 231, 87, 47),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Evento $i",
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
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
            backgroundColor: Color.fromARGB(206, 231, 87, 47),
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
