import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/events/events_page.dart';
import 'package:mobile_tixup/features/auth/services/cart_service.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/shop_viewmodel.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShopViewModel(),
      child: const _ShopScreenBody(),
    );
  }
}

class _ShopScreenBody extends StatelessWidget {
  const _ShopScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ShopViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
        centerTitle: true,
        title: const Icon(
          Icons.confirmation_number,
          size: 32,
          color: Colors.white,
        ),
        actions: viewModel.cartItems.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Limpar carrinho'),
                        content: const Text('Deseja remover todos os ingressos do carrinho?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await viewModel.clearCart(context);
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 249, 115, 22),
              ),
            )
          : viewModel.cartItems.isEmpty
              ? _buildEmptyCart(context)
              : _buildCartList(context, viewModel),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Carrinho',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Seus ingressos aparecerão aqui, você pode excluí-los ou realizar a compra.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color.fromARGB(255, 249, 115, 22),
                        width: 2,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 80,
                          color: Color.fromARGB(255, 249, 115, 22),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Seu carrinho está vazio',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaPesquisa()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 40.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Compre seu ingresso agora!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartList(BuildContext context, ShopViewModel viewModel) {
    double totalCartValue = 0;
    for (var item in viewModel.cartItems) {
      totalCartValue += (item['totalPrice'] as num).toDouble();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meu Carrinho',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'sans-serif',
                ),
              ),
              Text(
                '${viewModel.cartItems.length} ${viewModel.cartItems.length == 1 ? 'item' : 'itens'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 249, 115, 22),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'sans-serif',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            color: const Color.fromARGB(255, 249, 115, 22),
            onRefresh: () async {
              await viewModel.loadCartItems();
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: viewModel.cartItems.length,
              itemBuilder: (context, index) {
                final ticket = viewModel.cartItems[index];
                return _buildTicketCard(context, ticket, viewModel);
              },
            ),
          ),
        ),
        if (viewModel.cartItems.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    Text(
                      viewModel.formatPrice(totalCartValue),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 115, 22),
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Compra finalizada!'),
                          content: const Text('Seus ingressos foram comprados com sucesso!'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await viewModel.clearCart(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Finalizar Compra',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTicketCard(BuildContext context, Map<String, dynamic> ticket, ShopViewModel viewModel) {
    int totalTickets = 0;
    Map<String, dynamic> ticketCounts = Map<String, dynamic>.from(ticket['ticketCounts']);
    ticketCounts.forEach((type, count) {
      totalTickets += count as int;
    });

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: ticket['eventImage'] != null && ticket['eventImage'].isNotEmpty
                    ? Image.network(
                        ticket['eventImage'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'lib/assets/images/party6.jpg',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () => viewModel.removeFromCart(ticket['id'], context),
                  icon: const Icon(Icons.delete, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket['eventName'] ?? 'Evento',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans-serif',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Color.fromARGB(255, 249, 115, 22),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ticket['eventDate'] ?? 'Data não informada',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Color.fromARGB(255, 249, 115, 22),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ticket['eventLocation'] ?? 'Local não informado',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontFamily: 'sans-serif',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                
                ...ticketCounts.entries
                    .where((entry) => entry.value > 0)
                    .map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${entry.value}x ${entry.key}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                viewModel.formatPrice(entry.value * 55.0),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        )),
                const Divider(height: 24),
                
                const Text(
                  'Dados do comprador:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans-serif',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket['buyerName'] ?? 'Nome não informado',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  ticket['buyerEmail'] ?? 'Email não informado',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total ($totalTickets ${totalTickets == 1 ? 'ingresso' : 'ingressos'})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    Text(
                      viewModel.formatPrice((ticket['totalPrice'] as num).toDouble()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 115, 22),
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}