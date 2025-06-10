import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> allEvents = [
    {'data': '06 de Abr', 'nome': 'FILIN', 'local': 'Maringá/PR', 'valor': ' • 97,55'},
    {'data': '12 de Abr', 'nome': 'FOLKS', 'local': 'Maringá/PR', 'valor': ' • 55,90'},
    {'data': '19 de Abr', 'nome': 'DOUHA', 'local': 'Maringá/PR', 'valor': ' • 49,90'},
    {'data': '27 de Abr', 'nome': 'CASA DA VÓ', 'local': 'Maringá/PR', 'valor': ' • 37,50'},
    {'data': '04 de Mai', 'nome': 'BUTIQUIM', 'local': 'Maringá/PR', 'valor': ' • 99,90'},
    {'data': '11 de Mai', 'nome': 'NEW YORK', 'local': 'Maringá/PR', 'valor': ' • 29,90'},
    {'data': '18 de Mai', 'nome': 'BLACK NIGHT', 'local': 'Maringá/PR', 'valor': ' • 89,90'},
  ];
  List<Map<String, String>> filteredEvents = [];

  OrdersViewModel() {
    filteredEvents = allEvents;
    searchController.addListener(filterEvents);
  }

  void filterEvents() {
    final query = searchController.text.toLowerCase();
    filteredEvents = allEvents.where((evento) {
      return evento['nome']!.toLowerCase().contains(query) ||
          evento['local']!.toLowerCase().contains(query) ||
          evento['valor']!.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
} 