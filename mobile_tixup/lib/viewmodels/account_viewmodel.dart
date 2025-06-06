import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountViewModel extends ChangeNotifier {
  String nome = '';
  String email = '';
  String telefone = '';
  String endereco = '';
  String? caminhoImagem;

  AccountViewModel() {
    carregarDados();
  }

  Future<void> carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    nome = prefs.getString('nome') ?? '';
    email = prefs.getString('email') ?? '';
    telefone = prefs.getString('numero') ?? '';
    endereco = prefs.getString('endereco') ?? '';
    caminhoImagem = prefs.getString('imagemPerfil');
    notifyListeners();
  }

  File? get imageFile => caminhoImagem != null ? File(caminhoImagem!) : null;
} 