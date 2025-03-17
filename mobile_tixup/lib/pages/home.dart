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
