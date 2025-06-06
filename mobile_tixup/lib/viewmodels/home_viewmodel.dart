import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> allEvents = [];
  List<Map<String, dynamic>> highlightedEvents = [];
  List<Map<String, dynamic>> friendsLikedEvents = [];
  List<Map<String, dynamic>> recommendedEvents = [];
  bool isLoading = true;
  String? errorMessage;

  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);

  HomeViewModel() {
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final response = await Supabase.instance.client
          .from('eventos')
          .select()
          .order('data', ascending: true);
      allEvents =
          response.map<Map<String, dynamic>>((json) {
            return {
              'id': json['id'],
              'nome': json['nome'],
              'data': json['data'],
              'local': json['local'],
              'descricao': json['descricao'],
              'preco': json['preco'],
              'imagem': json['imagem'],
              'categoria': json['categoria'],
            };
          }).toList();
      highlightedEvents = List.from(allEvents);
      friendsLikedEvents = List.from(
        allEvents.where((event) => event['categoria'] == 'Festas').toList(),
      );
      recommendedEvents = List.from(
        allEvents.where((event) => event['categoria'] == 'Shows').toList(),
      );
      if (highlightedEvents.isEmpty && allEvents.isNotEmpty)
        highlightedEvents = List.from(allEvents);
      if (friendsLikedEvents.isEmpty && allEvents.isNotEmpty)
        friendsLikedEvents = List.from(allEvents);
      if (recommendedEvents.isEmpty && allEvents.isNotEmpty)
        recommendedEvents = List.from(allEvents);
      isLoading = false;
      notifyListeners();
    } on PostgrestException catch (e) {
      errorMessage = 'Erro ao carregar eventos: {e.message}';
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Ocorreu um erro inesperado: $e';
      isLoading = false;
      notifyListeners();
    }
  }
}
