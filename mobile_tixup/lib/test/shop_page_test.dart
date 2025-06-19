import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/features/shop/shop_page.dart';
import 'package:mobile_tixup/viewmodels/shop_viewmodel.dart';
import 'package:mobile_tixup/features/auth/services/cart_service.dart';

/// Mock de CartService
class TestCartService extends CartService {
  static List<Map<String, dynamic>> _mockCart = [];

  static Future<void> addToCart(Map<String, dynamic> ticketItem) async {
    _mockCart.add(ticketItem);
  }

  static Future<void> removeFromCart(String ticketId) async {
    _mockCart.removeWhere((item) => item['id'] == ticketId);
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    return List.from(_mockCart);
  }

  static Future<void> clearCart() async {
    _mockCart.clear();
  }

  static Map<String, dynamic> createTicketItem({
    required String eventId,
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventImage,
    required Map<String, int> ticketCounts,
    required double totalPrice,
    required String buyerName,
    required String buyerCpf,
    required String buyerEmail,
    required String buyerPhone,
  }) {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'eventId': eventId,
      'eventName': eventName,
      'eventDate': eventDate,
      'eventLocation': eventLocation,
      'eventImage': eventImage,
      'ticketCounts': ticketCounts,
      'totalPrice': totalPrice,
      'buyerName': buyerName,
      'buyerCpf': buyerCpf,
      'buyerEmail': buyerEmail,
      'buyerPhone': buyerPhone,
      'purchaseDate': DateTime.now().toString(),
    };
  }
}

/// Mock ViewModel
class TestShopViewModel extends ShopViewModel {
  TestShopViewModel();

  @override
  Future<void> loadCartItems() async {
    isLoading = true;
    notifyListeners();
    cartItems = await TestCartService.getCartItems();
    isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> removeFromCart(String ticketId, BuildContext context) async {
    await TestCartService.removeFromCart(ticketId);
    await loadCartItems();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresso removido do carrinho!'),
          backgroundColor: Colors.grey,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Future<void> clearCart(BuildContext context) async {
    await TestCartService.clearCart();
    await loadCartItems();
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}

void main() {
  group('ShopScreen Tests', () {
    Widget createTestWidget({required ShopViewModel viewModel}) {
      return MaterialApp(
        home: ChangeNotifierProvider<ShopViewModel>.value(
          value: viewModel,
          child: const ShopScreen(),
        ),
        routes: {'/events': (context) => const TelaPesquisa()},
      );
    }

    setUp(() {
      TestCartService._mockCart = [];
    });

    testWidgets('Exibe AppBar e texto "Carrinho" quando está vazio', (
      tester,
    ) async {
      final viewModel = TestShopViewModel();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Carrinho'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets(
      'Exibe mensagem e botão "Compre seu ingresso agora!" quando carrinho está vazio',
      (tester) async {
        final viewModel = TestShopViewModel();
        await tester.pumpWidget(createTestWidget(viewModel: viewModel));

        expect(find.text('Seu carrinho está vazio'), findsOneWidget);
        expect(find.text('Compre seu ingresso agora!'), findsOneWidget);
      },
    );

    testWidgets(
      'Navega para TelaPesquisa ao clicar em "Compre seu ingresso agora!"',
      (tester) async {
        final viewModel = TestShopViewModel();
        await tester.pumpWidget(createTestWidget(viewModel: viewModel));

        await tester.tap(find.text('Compre seu ingresso agora!'));
        await tester.pumpAndSettle();

        expect(find.byType(TelaPesquisa), findsOneWidget);
      },
    );

    testWidgets('Exibe CircularProgressIndicator quando isLoading é true', (
      tester,
    ) async {
      final viewModel = TestShopViewModel()..isLoading = true;
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'Exibe lista de carrinho e botão "Finalizar Compra" quando há itens',
      (tester) async {
        final viewModel = TestShopViewModel();
        final ticket = TestCartService.createTicketItem(
          eventId: '1',
          eventName: 'Evento Teste',
          eventDate: '18/06/2025',
          eventLocation: 'Local Teste',
          eventImage: '',
          ticketCounts: {'VIP': 1},
          totalPrice: 105.0,
          buyerName: 'Teste',
          buyerCpf: '12345678901',
          buyerEmail: 'teste@example.com',
          buyerPhone: '123456789',
        );
        await TestCartService.addToCart(ticket);
        await viewModel.loadCartItems();
        await tester.pumpWidget(createTestWidget(viewModel: viewModel));
        await tester.pumpAndSettle();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Meu Carrinho'), findsOneWidget);
        expect(find.text('Finalizar Compra'), findsOneWidget);
      },
    );

    testWidgets('Remove item do carrinho e exibe SnackBar', (tester) async {
      final viewModel = TestShopViewModel();
      final ticket = TestCartService.createTicketItem(
        eventId: '1',
        eventName: 'Evento Teste',
        eventDate: '18/06/2025',
        eventLocation: 'Local Teste',
        eventImage: '',
        ticketCounts: {'VIP': 1},
        totalPrice: 105.0,
        buyerName: 'Teste',
        buyerCpf: '12345678901',
        buyerEmail: 'teste@example.com',
        buyerPhone: '123456789',
      );
      await TestCartService.addToCart(ticket);
      await viewModel.loadCartItems();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));
      await tester.pumpAndSettle();

      final deleteButton = find.byIcon(Icons.delete);
      expect(deleteButton, findsOneWidget);

      await tester.tap(deleteButton);
      await tester.pump();

      expect(find.text('Ingresso removido do carrinho!'), findsOneWidget);
      expect(viewModel.cartItems, isEmpty);
    });

    testWidgets('Limpa carrinho usando botão de limpar', (tester) async {
      final viewModel = TestShopViewModel();
      final ticket = TestCartService.createTicketItem(
        eventId: '1',
        eventName: 'Evento Teste',
        eventDate: '18/06/2025',
        eventLocation: 'Local Teste',
        eventImage: '',
        ticketCounts: {'VIP': 2},
        totalPrice: 210.0,
        buyerName: 'Teste',
        buyerCpf: '12345678901',
        buyerEmail: 'teste@example.com',
        buyerPhone: '123456789',
      );
      await TestCartService.addToCart(ticket);
      await viewModel.loadCartItems();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete_outline), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(find.text('Limpar carrinho'), findsOneWidget);
      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle();

      expect(viewModel.cartItems, isEmpty);
    });
  });
}
