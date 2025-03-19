import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
          elevation: 0,
          title: Text('Salve, (nome da pessoa)!!'),
          actions: [
            IconButton(
              onPressed: () {
                //logica para abrir busca
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                //logica para abrir carrinho
              },
              icon: Icon(Icons.store_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

Widget content(BuildContext context) {
  return Container(
    child: CarouselSlider(
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
      options: CarouselOptions(height: 300),
    ),
  );
}
