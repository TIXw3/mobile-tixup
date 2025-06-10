import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_events';

  static Future<void> addToFavorites(Map<String, dynamic> evento) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    String eventoJson = jsonEncode(evento);
    
    bool alreadyExists = favorites.any((item) {
      Map<String, dynamic> existingEvent = jsonDecode(item);
      return existingEvent['id'] == evento['id'];
    });
    
    if (!alreadyExists) {
      favorites.add(eventoJson);
      await prefs.setStringList(_favoritesKey, favorites);
    }
    
    await prefs.setBool('event_favorite_${evento['id']}', true);
  }

  static Future<void> removeFromFavorites(String eventoId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    favorites.removeWhere((item) {
      Map<String, dynamic> evento = jsonDecode(item);
      return evento['id'] == eventoId;
    });
    
    await prefs.setStringList(_favoritesKey, favorites);
    await prefs.setBool('event_favorite_$eventoId', false);
  }

  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    
    return favorites.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  static Future<bool> isFavorite(String eventoId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('event_favorite_$eventoId') ?? false;
  }

  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}