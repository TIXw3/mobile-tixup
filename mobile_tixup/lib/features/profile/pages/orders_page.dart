import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/orders_viewmodel.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdersViewModel(),
      child: const _OrdersScreenBody(),
    );
  }
}

class _OrdersScreenBody extends StatelessWidget {
  const _OrdersScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrdersViewModel>(context);
    final Color orange500 = const Color.fromARGB(255, 249, 115, 22);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextField(
              controller: viewModel.searchController,
              style: const TextStyle(
                fontFamily: 'sans-serif',
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar compras...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: 'sans-serif',
                ),
                prefixIcon: Icon(Icons.search, color: orange500),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: orange500, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: viewModel.filteredEvents.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_outlined, size: 80, color: orange500),
                        const SizedBox(height: 20),
                        Text(
                          'Nenhum resultado encontrado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: orange500,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: viewModel.filteredEvents.length,
                      itemBuilder: (context, index) {
                        return _buildEventoCard(viewModel.filteredEvents[index], orange500);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventoCard(Map<String, String> evento, Color orange500) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: orange500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.event_available, size: 36, color: orange500),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black),
                      const SizedBox(width: 4),
                      Text(
                        evento['data']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'sans-serif',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento['nome']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: orange500,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        evento['local']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'sans-serif',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          color: orange500.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'R\$${evento['valor']!.replaceAll("•", "").trim()}',
                          style: TextStyle(
                            color: orange500,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
