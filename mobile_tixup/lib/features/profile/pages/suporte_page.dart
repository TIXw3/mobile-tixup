import 'package:flutter/material.dart';

class TelaDeSuporte extends StatelessWidget {
  TelaDeSuporte({Key? key}) : super(key: key);

  final Color orange500 = const Color.fromARGB(255, 249, 115, 22);
  final Color black = const Color.fromRGBO(33, 33, 33, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ainda está com dificuldades?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: black,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Entre em contato com o nosso suporte para mais ajuda.',
              style: TextStyle(
                fontSize: 16,
                color: black.withOpacity(0.7),
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suporte Técnico:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: orange500,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email_outlined, color: orange500, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          'tixupsuporte@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Entrar em Contato',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
