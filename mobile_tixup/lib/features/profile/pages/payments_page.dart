import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FocusNode cvvFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    cvvFocusNode.addListener(() {
      if (cvvFocusNode.hasFocus) {
        cardKey.currentState?.toggleCard();
      } else {
        cardKey.currentState?.toggleCard();
      }
    });
  }

  @override
  void dispose() {
    cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FlipCard(
              key: cardKey,
              flipOnTouch: false,
              direction: FlipDirection.HORIZONTAL,
              front: _buildCardFront(),
              back: _buildCardBack(),
            ),

            const SizedBox(height: 30),

            const CardInputField(
              icon: Icons.credit_card,
              hintText: 'Número do Cartão',
            ),
            const SizedBox(height: 12),
            const CardInputField(icon: Icons.person, hintText: 'Nome Completo'),
            const SizedBox(height: 12),

            Row(
              children: [
                const Expanded(
                  child: CardInputField(
                    icon: Icons.date_range,
                    hintText: 'MM/YY',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    focusNode: cvvFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'CVV',
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // lógica de adicionar cartão
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Adicionar cartão',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.deepOrange, Color.fromARGB(255, 249, 115, 22)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('TixCard', style: TextStyle(color: Colors.white, fontSize: 18)),
          Spacer(),
          Text(
            'XXXX  XXXX  XXXX  XXXX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Info\nCartao',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                'Validade\n08/2022',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 249, 115, 22), Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          SizedBox(height: 30),
          Text(
            'CVV: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 4,
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              '',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class CardInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  const CardInputField({Key? key, required this.icon, required this.hintText})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
