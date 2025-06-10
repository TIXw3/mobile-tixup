import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/cart_service.dart';

class ShopViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  ShopViewModel() {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    isLoading = true;
    notifyListeners();
    cartItems = await CartService.getCartItems();
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeFromCart(String ticketId, BuildContext context) async {
    await CartService.removeFromCart(ticketId);
    await loadCartItems();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ingresso removido do carrinho!'),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> clearCart(BuildContext context) async {
    await CartService.clearCart();
    await loadCartItems();
    Navigator.pop(context);
  }

  String formatPrice(double price) {
    return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }
} 