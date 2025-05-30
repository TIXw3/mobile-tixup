import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String _cartKey = 'cart_tickets';

  static Map<String, dynamic> createTicketItem({
    required String eventId,
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventImage,
    required Map<String, int> ticketCounts,
    required double totalPrice,
    required String buyerName,
    required String buyerCpf,
    required String buyerEmail,
    required String buyerPhone,
  }) {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'eventId': eventId,
      'eventName': eventName,
      'eventDate': eventDate,
      'eventLocation': eventLocation,
      'eventImage': eventImage,
      'ticketCounts': ticketCounts,
      'totalPrice': totalPrice,
      'buyerName': buyerName,
      'buyerCpf': buyerCpf,
      'buyerEmail': buyerEmail,
      'buyerPhone': buyerPhone,
      'purchaseDate': DateTime.now().toString(),
    };
  }

  static Future<void> addToCart(Map<String, dynamic> ticketItem) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    String ticketJson = jsonEncode(ticketItem);
    
    cart.add(ticketJson);
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> removeFromCart(String ticketId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    cart.removeWhere((item) {
      Map<String, dynamic> ticket = jsonDecode(item);
      return ticket['id'] == ticketId;
    });
    
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];
    
    return cart.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  static double calculateTicketPrice(Map<String, int> ticketCounts) {
    double total = 0;
    
    const Map<String, double> prices = {
      'Pista': 50.0,
      'VIP': 100.0,
      'Camarote': 150.0,
    };
    
    const double serviceFee = 5.0;
    
    ticketCounts.forEach((type, count) {
      if (prices.containsKey(type)) {
        total += (prices[type]! + serviceFee) * count;
      }
    });
    
    return total;
  }
}