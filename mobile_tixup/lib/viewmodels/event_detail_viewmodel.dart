import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/favorites_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';

class EventDetailViewModel extends ChangeNotifier {
  late Map<String, int> ticketCounts;
  bool isFavorite = false;
  final Map<String, dynamic> eventoData;

  EventDetailViewModel({required this.eventoData, required Map<String, int> initialTicketCounts}) {
    ticketCounts = Map.from(initialTicketCounts);
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final eventId = eventoData['id']?.toString() ?? 'unknown';
    final favoriteStatus = await FavoritesService.isFavorite(eventId);
    isFavorite = favoriteStatus;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final eventId = eventoData['id']?.toString() ?? 'unknown';
    isFavorite = !isFavorite;
    notifyListeners();
    if (isFavorite) {
      await FavoritesService.addToFavorites(eventoData);
    } else {
      await FavoritesService.removeFromFavorites(eventId);
    }
  }

  void increment(String type) {
    ticketCounts[type] = (ticketCounts[type] ?? 0) + 1;
    notifyListeners();
  }

  void decrement(String type) {
    if ((ticketCounts[type] ?? 0) > 0) {
      ticketCounts[type] = ticketCounts[type]! - 1;
      notifyListeners();
    }
  }

  void shareEvent() {
    final message = '''\nConfira este evento incrível!\n\nNome: ${eventoData['nome'] ?? 'Evento'}\nData: ${eventoData['data'] ?? ''}\nLocal: ${eventoData['local'] ?? ''}\nDescrição: ${eventoData['descricao'] ?? ''}\n\nCompre já seu ingresso pelo app Tixup!\n''';
    Share.share(message);
  }

  bool hasSelectedTickets() {
    return ticketCounts.values.any((count) => count > 0);
  }

  Future<void> savePurchaseData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('purchase_eventoData', jsonEncode(eventoData));
    await prefs.setString('purchase_ticketCounts', jsonEncode(ticketCounts));
  }
} 