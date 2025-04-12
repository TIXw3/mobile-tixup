import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 115, 22),
        centerTitle: true,
        title: const Icon(
          Icons.confirmation_number,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 140),
            const Text(
              'Carrinho',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Seus ingressos aparecerão aqui, você pode excluí-los ou realizar a compra.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepOrange[50],
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Color.fromARGB(255, 249, 115, 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Seu carrinho está vazio',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Ação para comprar ingressos
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 249, 115, 22),
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Compre seu ingresso agora!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'sans-serif',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
