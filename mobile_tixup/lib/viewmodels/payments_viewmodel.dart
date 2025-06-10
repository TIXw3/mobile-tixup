import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentsViewModel extends ChangeNotifier {
  final PageController pageController = PageController(viewportFraction: 0.95);
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final cardNumberFormatter = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  final expiryFormatter = MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  final cvvFormatter = MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  List<Map<String, String>> addedCards = [];

  void addCard() {
    if (numberController.text.isEmpty ||
        nameController.text.isEmpty ||
        expiryController.text.isEmpty ||
        cvvController.text.isEmpty) {
      return;
    }
    addedCards.add({
      'number': numberController.text,
      'name': nameController.text,
      'expiry': expiryController.text,
    });
    numberController.clear();
    nameController.clear();
    expiryController.clear();
    cvvController.clear();
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100), () {
      pageController.animateToPage(
        addedCards.length - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    numberController.dispose();
    nameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    pageController.dispose();
    super.dispose();
  }
} 