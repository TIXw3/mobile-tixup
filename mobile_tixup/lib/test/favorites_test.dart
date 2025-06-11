import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/favorites_viewmodel.dart';
import 'package:mobile_tixup/features/favorites/favorites_page.dart';

class MockFavoritesViewModel extends FavoritesViewModel {
  @override
  bool isLoading = false;

  @override
  List<Map<String, dynamic>> favoriteEvents = [];

  @override
  Future<void> loadFavorites() async {}
}

void main() {
  testWidgets('Exibe loading quando isLoading true', (
    WidgetTester tester,
  ) async {
    final mockViewModel = MockFavoritesViewModel();
    mockViewModel.isLoading = true;

    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(home: FavoriteScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Exibe estado vazio quando não tem favoritos', (
    WidgetTester tester,
  ) async {
    final mockViewModel = MockFavoritesViewModel();
    mockViewModel.isLoading = false;
    mockViewModel.favoriteEvents = [];

    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(home: FavoriteScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Favoritos'), findsOneWidget);
    expect(find.text('Suas curtidas irão aparecer aqui!'), findsOneWidget);
    expect(find.text('Você ainda não curtiu nenhum evento'), findsOneWidget);
    expect(find.text('Explorar eventos'), findsOneWidget);
  });

  testWidgets('Exibe lista de eventos favoritos quando tem dados', (
    WidgetTester tester,
  ) async {
    final mockViewModel = MockFavoritesViewModel();
    mockViewModel.isLoading = false;
    mockViewModel.favoriteEvents = [
      {
        'id': '1',
        'nome': 'Festa Eliel',
        'data': '01/01/2025',
        'local': 'Clube Toscano',
        'imagem': '',
      },
    ];

    await tester.pumpWidget(
      ChangeNotifierProvider<FavoritesViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(home: FavoriteScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Meus Favoritos'), findsOneWidget);
    expect(find.text('Festa Eliel'), findsOneWidget);
    expect(find.text('01/01/2025'), findsOneWidget);
    expect(find.text('Clube Toscano'), findsOneWidget);
  });
}
