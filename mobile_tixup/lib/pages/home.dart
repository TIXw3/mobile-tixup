import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tixup/nav_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
        title: Text('Salve, (nome da pessoa)!!'),
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
            icon: Icon(Icons.store_rounded),
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
            SizedBox(height: 20), // espaçamento resto
          ],
        ),
      ),
      bottomNavigationBar: NavigationMenu(),
    );
  }
}

Widget content(BuildContext context) {
  return CarouselSlider(
    items:
        [1, 2, 3, 4, 5].map((i) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
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
              color: Colors.deepOrangeAccent,
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
