import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventsViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allEvents = [];
  List<Map<String, dynamic>> filteredEvents = [];
  bool isLoading = true;
  String? errorMessage;

  EventsViewModel() {
    searchController.addListener(filterEvents);
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final data = await Supabase.instance.client
          .from('eventos')
          .select()
          .order('data', ascending: true);
      allEvents = data.map<Map<String, dynamic>>((json) {
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
      filteredEvents = allEvents;
      isLoading = false;
      notifyListeners();
    } on PostgrestException catch (e) {
      errorMessage = 'Erro ao carregar eventos: ${e.message}';
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Ocorreu um erro inesperado: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  void filterEvents() {
    final query = searchController.text.toLowerCase();
    filteredEvents = allEvents.where((evento) {
      final nome = (evento['nome'] ?? '').toString().toLowerCase();
      final local = (evento['local'] ?? '').toString().toLowerCase();
      final descricao = (evento['descricao'] ?? '').toString().toLowerCase();
      final categoria = (evento['categoria'] ?? '').toString().toLowerCase();
      final data = (evento['data'] ?? '').toString().toLowerCase();
      return nome.contains(query) ||
          local.contains(query) ||
          descricao.contains(query) ||
          categoria.contains(query) ||
          data.contains(query);
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
} 