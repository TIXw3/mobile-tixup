import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> favoriteEvents = [];
  bool isLoading = true;

  FavoritesViewModel() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading = true;
    notifyListeners();
    favoriteEvents = await FavoritesService.getFavorites();
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeFromFavorites(String eventoId, BuildContext context) async {
    await FavoritesService.removeFromFavorites(eventoId);
    await loadFavorites();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Evento removido dos favoritos!'),
        backgroundColor: Colors.grey[600],
        duration: const Duration(seconds: 2),
      ),
    );
  }
} 