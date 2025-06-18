import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/favorites/favorites_page.dart';
import 'package:mobile_tixup/viewmodels/favorites_viewmodel.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:provider/provider.dart';

class TestFavoritesViewModel extends FavoritesViewModel {
  TestFavoritesViewModel({
    bool isLoading = false,
    List<Map<String, dynamic>>? mockFavorites,
  }) {
    this.isLoading = isLoading;
    favoriteEvents = mockFavorites ?? [];
  }

  @override
  Future<void> loadFavorites() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> removeFromFavorites(String eventoId, BuildContext context) async {
    favoriteEvents.removeWhere((item) => item['id'] == eventoId);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Evento removido dos favoritos!')),
    );
  }
}

void main() {
  group('FavoriteScreen Tests', () {
    Widget createTestWidget({required FavoritesViewModel viewModel}) {
      return MaterialApp(
        home: ChangeNotifierProvider<FavoritesViewModel>.value(
          value: viewModel,
          child: const FavoriteScreen(),
        ),
        routes: {
          '/events': (context) => const TelaPesquisa(),
        },
      );
    }

    testWidgets('Exibe CircularProgressIndicator quando está carregando', (tester) async {
      final viewModel = TestFavoritesViewModel(isLoading: true);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Exibe estado vazio quando não há favoritos', (tester) async {
      final viewModel = TestFavoritesViewModel(mockFavorites: []);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.text('Favoritos'), findsOneWidget);
      expect(find.text('Suas curtidas irão aparecer aqui!'), findsOneWidget);
      expect(find.text('Explorar eventos'), findsOneWidget);
    });

    testWidgets('Navega para TelaPesquisa ao clicar em "Explorar eventos"', (tester) async {
      final viewModel = TestFavoritesViewModel(mockFavorites: []);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      await tester.tap(find.text('Explorar eventos'));
      await tester.pumpAndSettle();

      expect(find.byType(TelaPesquisa), findsOneWidget);
    });

    testWidgets('Exibe lista de favoritos corretamente', (tester) async {
      final viewModel = TestFavoritesViewModel(mockFavorites: [
        {
          'id': '1',
          'nome': 'Festa Incrível',
          'data': '25/07/2025',
          'local': 'Rua das Flores',
          'imagem': '',
        }
      ]);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.text('Meus Favoritos'), findsOneWidget);
      expect(find.text('Festa Incrível'), findsOneWidget);
      expect(find.text('25/07/2025'), findsOneWidget);
      expect(find.text('Rua das Flores'), findsOneWidget);
    });

    testWidgets('Remove item dos favoritos e exibe SnackBar', (tester) async {
      final viewModel = TestFavoritesViewModel(mockFavorites: [
        {
          'id': '1',
          'nome': 'Festa Incrível',
          'data': '25/07/2025',
          'local': 'Rua das Flores',
          'imagem': '',
        }
      ]);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      final removeButton = find.byIcon(Icons.favorite);
      expect(removeButton, findsOneWidget);

      await tester.tap(removeButton);
      await tester.pump();

      expect(find.text('Evento removido dos favoritos!'), findsOneWidget);
      expect(viewModel.favoriteEvents.length, 0);
    });
  });
}
