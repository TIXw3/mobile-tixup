import 'package:flutter/material.dart';

class StudentIdViewModel extends ChangeNotifier {
  final List<Map<String, String>> carteirinhas = [
    {
      'nome': 'Lucas B Ovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 12/2025',
      'instituicao': 'Unicesumar',
    },
    {
      'nome': 'Lucas Bovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 08/2025',
      'instituicao': 'Santa Cruz',
    },
    {
      'nome': 'Lucas de Freitas',
      'tipo': 'Convidade',
      'validade': 'Validade: 03/2026',
      'instituicao': 'ExpoInga',
    },
    {
      'nome': 'Lucas B Ovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 12/2025',
      'instituicao': 'Unicesumar',
    },
    {
      'nome': 'Lucas Bovo',
      'tipo': 'Estudante',
      'validade': 'Validade: 08/2025',
      'instituicao': 'Santa Cruz',
    },
  ];

  void adicionarCarteirinha(Map<String, String> nova) {
    carteirinhas.add(nova);
    notifyListeners();
  }

  void editarCarteirinha(int index, Map<String, String> nova) {
    carteirinhas[index] = nova;
    notifyListeners();
  }
} 