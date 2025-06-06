import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  File? profileImage;
  String nome = '';
  String email = '';
  String numero = '';
  String endereco = '';
  final ImagePicker picker = ImagePicker();

  EditProfileViewModel() {
    carregarDadosPerfil();
  }

  Future<void> carregarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    nome = prefs.getString('nome') ?? 'Lucas Gabriel';
    email = prefs.getString('email') ?? 'email@email.com';
    numero = prefs.getString('numero') ?? '(44) 99999-0000';
    endereco = prefs.getString('endereco') ?? 'Rua X, Jardim Y, 89898993';
    final caminhoImagem = prefs.getString('imagemPerfil');
    if (caminhoImagem != null) {
      profileImage = File(caminhoImagem);
    }
    notifyListeners();
  }

  Future<void> salvarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nome);
    await prefs.setString('email', email);
    await prefs.setString('numero', numero);
    await prefs.setString('endereco', endereco);
    if (profileImage != null) {
      await prefs.setString('imagemPerfil', profileImage!.path);
    }
    notifyListeners();
  }

  Future<void> selecionarImagem(BuildContext context) async {
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha uma opção'),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, image);
            },
            child: const Text('Galeria'),
          ),
          TextButton(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, image);
            },
            child: const Text('Câmera'),
          ),
        ],
      ),
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }
} 