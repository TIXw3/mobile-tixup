import 'package:flutter/material.dart';

class SellTicketsViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController eventoController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController tipoIngressoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  void disposeControllers() {
    eventoController.dispose();
    dataController.dispose();
    localController.dispose();
    tipoIngressoController.dispose();
    precoController.dispose();
  }

  bool venderIngresso(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresso publicado com sucesso!')),
      );
      return true;
    }
    return false;
  }
} 