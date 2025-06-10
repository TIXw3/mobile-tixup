import 'package:flutter/material.dart';

class FollowingViewModel extends ChangeNotifier {
  String selectedOrder = 'A-Z';

  final List<Map<String, String>> organizadores = [
    {'nome': 'BUTIQUIM', 'descricao': 'É o Butica da galera!'},
    {'nome': 'FILIN', 'descricao': 'Única e Surpreendente!'},
  ];

  List<Map<String, String>> get organizadoresOrdenados {
    List<Map<String, String>> sorted = List.from(organizadores);
    switch (selectedOrder) {
      case 'A-Z':
        sorted.sort((a, b) => a['nome']!.compareTo(b['nome']!));
        break;
      case 'Z-A':
        sorted.sort((a, b) => b['nome']!.compareTo(a['nome']!));
        break;
      case 'Mais Recentes':
        sorted = sorted.reversed.toList();
        break;
      case 'Mais Antigos':
        break;
    }
    return sorted;
  }

  void setOrder(String order) {
    selectedOrder = order;
    notifyListeners();
  }
} 