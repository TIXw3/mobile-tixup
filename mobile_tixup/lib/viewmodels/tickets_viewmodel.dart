import 'package:flutter/material.dart';

class TicketsViewModel extends ChangeNotifier {
  final List<Map<String, String>> meusIngressos = [
    {
      'data': '06 de Abr',
      'evento': 'FILIN',
      'local': 'Maringá/PR',
      'qrcode': '1234567890',
    },
    {
      'data': '12 de Abr',
      'evento': 'FOLKS',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '15 de Abr',
      'evento': 'NEW YORK',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '18 de Out',
      'evento': 'FILIN',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '12 de Jan',
      'evento': 'ExpoInga',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
    {
      'data': '2 de Jul',
      'evento': 'BUTIQUIM',
      'local': 'Maringá/PR',
      'qrcode': '0987654321',
    },
  ];
} 