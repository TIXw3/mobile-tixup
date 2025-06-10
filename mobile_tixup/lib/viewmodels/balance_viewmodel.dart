import 'package:flutter/material.dart';

class BalanceViewModel extends ChangeNotifier {
  double saldo = 0.0;
  final List<Map<String, String>> historico = [];
} 