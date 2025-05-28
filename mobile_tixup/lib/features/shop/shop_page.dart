import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/events_page.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
        centerTitle: true,
        title: const Icon(
          Icons.confirmation_number,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color.fromARGB(255, 249, 115, 22),
                          width: 2,
                        ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TelaPesquisa()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
