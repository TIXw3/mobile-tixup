import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FocusNode cvvFocusNode = FocusNode();

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  final cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final expiryFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final cvvFormatter = MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  List<Map<String, String>> addedCards = [];

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
    numberController.dispose();
    nameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    cvvFocusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  String? getCardBrand(String cardNumber) {
    final cleaned = cardNumber.replaceAll(' ', '');
    if (cleaned.startsWith(RegExp(r'4'))) return 'Visa';
    if (cleaned.startsWith(RegExp(r'5[1-5]'))) return 'Mastercard';
    if (cleaned.startsWith(RegExp(r'3[47]'))) return 'American Express';
    if (cleaned.startsWith(RegExp(r'6'))) return 'Discover';
    return null;
  }

  Widget? getCardBrandIcon(String? brand) {
    switch (brand) {
      case 'Visa':
        return Image.asset('lib/assets/cards/visa.png', width: 60);
      case 'Mastercard':
        return Image.asset('lib/assets/cards/mastercard.png', width: 60);
      case 'American Express':
        return Image.asset('lib/assets/cards/amex.png', width: 60);
      case 'Discover':
        return Image.asset('lib/assets/cards/discover.png', width: 60);
      default:
        return null;
    }
  }

  Widget buildCard(Map<String, String> data) {
    final brand = getCardBrand(data['number'] ?? '');
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TixCard',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              if (brand != null) getCardBrandIcon(brand) ?? Container(),
            ],
          ),
          const Spacer(),
          Text(
            data['number'] ?? 'XXXX XXXX XXXX XXXX',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['name'] ?? '',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                'Validade\n${data['expiry'] ?? ''}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addCard() {
    if (numberController.text.isEmpty ||
        nameController.text.isEmpty ||
        expiryController.text.isEmpty ||
        cvvController.text.isEmpty) {
      return;
    }

    setState(() {
      addedCards.add({
        'number': numberController.text,
        'name': nameController.text,
        'expiry': expiryController.text,
      });

      numberController.clear();
      nameController.clear();
      expiryController.clear();
      cvvController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _pageController.animateToPage(
        addedCards.length - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 210,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: addedCards.length + 1,
                          itemBuilder: (context, index) {
                            if (index < addedCards.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: buildCard(addedCards[index]),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: FlipCard(
                                key: cardKey,
                                flipOnTouch: false,
                                direction: FlipDirection.HORIZONTAL,
                                front: _buildCardFront(),
                                back: _buildCardBack(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        icon: Icons.credit_card,
                        hintText: 'Número do Cartão',
                        controller: numberController,
                        inputFormatters: [cardNumberFormatter],
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        icon: Icons.person,
                        hintText: 'Nome Completo',
                        controller: nameController,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.date_range,
                              hintText: 'MM/YY',
                              controller: expiryController,
                              inputFormatters: [expiryFormatter],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.lock,
                              hintText: 'CVV',
                              controller: cvvController,
                              inputFormatters: [cvvFormatter],
                              focusNode: cvvFocusNode,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addCard,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              249,
                              115,
                              22,
                            ),
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
  required IconData icon,
  required String hintText,
  required TextEditingController controller,
  List<TextInputFormatter>? inputFormatters,
  FocusNode? focusNode,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    inputFormatters: inputFormatters,
    onChanged: (_) => setState(() {}),
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
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 249, 115, 22), 
          width: 2,
        ),
      ),
    ),
  );
}



  Widget _buildCardFront() {
    final brand = getCardBrand(numberController.text);
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TixCard',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              if (brand != null) getCardBrandIcon(brand) ?? Container(),
            ],
          ),
          const Spacer(),
          Text(
            numberController.text.isEmpty
                ? 'XXXX XXXX XXXX XXXX'
                : numberController.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nameController.text.isEmpty
                    ? 'Nome Completo'
                    : nameController.text,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                expiryController.text.isEmpty
                    ? 'Validade\nMM/YY'
                    : 'Validade\n${expiryController.text}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 60, height: 15, color: Colors.black),
              const SizedBox(width: 30),
              Text(
                cvvController.text.isEmpty ? 'CVV' : cvvController.text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
