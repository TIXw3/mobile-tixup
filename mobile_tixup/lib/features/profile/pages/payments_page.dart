import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/payments_viewmodel.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentsViewModel(),
      child: const _PaymentsPageBody(),
    );
  }
}

class _PaymentsPageBody extends StatelessWidget {
  const _PaymentsPageBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PaymentsViewModel>(context);
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
                          controller: viewModel.pageController,
                          itemCount: viewModel.addedCards.length + 1,
                          itemBuilder: (context, index) {
                            if (index < viewModel.addedCards.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: buildCard(viewModel.addedCards[index]),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: FlipCard(
                                key: GlobalKey<FlipCardState>(),
                                flipOnTouch: false,
                                direction: FlipDirection.HORIZONTAL,
                                front: _buildCardFront(viewModel),
                                back: _buildCardBack(viewModel),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        icon: Icons.credit_card,
                        hintText: 'Número do Cartão',
                        controller: viewModel.numberController,
                        inputFormatters: [viewModel.cardNumberFormatter],
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        icon: Icons.person,
                        hintText: 'Nome Completo',
                        controller: viewModel.nameController,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.date_range,
                              hintText: 'MM/YY',
                              controller: viewModel.expiryController,
                              inputFormatters: [viewModel.expiryFormatter],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              icon: Icons.lock,
                              hintText: 'CVV',
                              controller: viewModel.cvvController,
                              inputFormatters: [viewModel.cvvFormatter],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: viewModel.addCard,
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

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
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
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 249, 115, 22),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildCardFront(PaymentsViewModel viewModel) {
    final brand = getCardBrand(viewModel.numberController.text);
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
            viewModel.numberController.text.isEmpty
                ? 'XXXX XXXX XXXX XXXX'
                : viewModel.numberController.text,
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
                viewModel.nameController.text.isEmpty
                    ? 'Nome Completo'
                    : viewModel.nameController.text,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                viewModel.expiryController.text.isEmpty
                    ? 'Validade\nMM/YY'
                    : 'Validade\n${viewModel.expiryController.text}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(PaymentsViewModel viewModel) {
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
                viewModel.cvvController.text.isEmpty ? 'CVV' : viewModel.cvvController.text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
