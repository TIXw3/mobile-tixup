import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InformationPurchasePage extends StatefulWidget {
  const InformationPurchasePage({super.key});

  @override
  State<InformationPurchasePage> createState() => _InformationPurchasePageState();
}

class _InformationPurchasePageState extends State<InformationPurchasePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Color orange500 = const Color.fromARGB(255, 249, 115, 22);
  double totalPrice = 0.0;
  bool hasEventData = false;
  Map<String, dynamic>? eventoData;
  Map<String, int>? ticketCounts;

  @override
  void initState() {
    super.initState();
    _loadPurchaseData();
  }

  Future<void> _loadPurchaseData() async {
    final prefs = await SharedPreferences.getInstance();
    final eventoDataString = prefs.getString('purchase_eventoData');
    final ticketCountsString = prefs.getString('purchase_ticketCounts');

    if (eventoDataString != null && ticketCountsString != null) {
      final Map<String, double> ticketPrices = {
        'Pista': 55.0,
        'VIP': 85.0,
        'Camarote': 100.0,
      };

      setState(() {
        eventoData = jsonDecode(eventoDataString) as Map<String, dynamic>;
        ticketCounts = (jsonDecode(ticketCountsString) as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int));
        hasEventData = true;
        totalPrice = ticketCounts!.entries.fold(0.0, (sum, entry) {
          final price = ticketPrices[entry.key] ?? 55.0; 
          return sum + (entry.value * price);
        });
      });
    }
  }

  String formatPrice(double price) {
    return 'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  int getTotalTickets() {
    if (!hasEventData || ticketCounts == null) return 0;
    int total = 0;
    ticketCounts!.forEach((type, count) {
      total += count;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informações da Compra',
          style: TextStyle(
            fontFamily: 'sans-serif',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasEventData) ...[
                _sectionTitle("Resumo da Compra", orange500),
                const SizedBox(height: 16),
                _buildPurchaseSummary(),
                const SizedBox(height: 32),
              ],
              _sectionTitle("Preencha seus dados", orange500),
              const SizedBox(height: 16),
              _buildTextField(
                  label: "Nome completo",
                  controller: _nameController,
                  validatorMsg: "Informe seu nome"),
              _buildTextField(
                  label: "CPF",
                  controller: _cpfController,
                  validatorMsg: "Informe seu CPF"),
              _buildTextField(
                  label: "E-mail",
                  controller: _emailController,
                  validatorMsg: "Informe seu e-mail",
                  inputType: TextInputType.emailAddress),
              _buildTextField(
                  label: "Telefone",
                  controller: _phoneController,
                  validatorMsg: "Informe seu telefone",
                  inputType: TextInputType.phone),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange500,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (hasEventData) {
                        _addToCart();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Erro"),
                            content: const Text("Dados do evento ou ingressos não disponíveis."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Confirmar Compra",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addToCart() async {
    final ticketItem = CartService.createTicketItem(
      eventId: eventoData!['id'] ?? DateTime.now().toString(),
      eventName: eventoData!['nome'] ?? 'Evento',
      eventDate: eventoData!['data'] ?? 'Data não informada',
      eventLocation: eventoData!['local'] ?? 'Local não informado',
      eventImage: eventoData!['imagem'] ?? '',
      ticketCounts: ticketCounts!,
      totalPrice: totalPrice,
      buyerName: _nameController.text,
      buyerCpf: _cpfController.text,
      buyerEmail: _emailController.text,
      buyerPhone: _phoneController.text,
    );

    await CartService.addToCart(ticketItem);

    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('purchase_eventoData');
      await prefs.remove('purchase_ticketCounts');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Compra confirmada!"),
          content: const Text("Seus ingressos foram adicionados ao carrinho."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(color: orange500),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildPurchaseSummary() {
    if (!hasEventData || eventoData == null || ticketCounts == null) return Container();
    
    final Map<String, double> ticketPrices = {
      'Pista': 55.0,
      'VIP': 85.0,
      'Camarote': 100.0,
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: orange500, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventoData!['nome'] ?? 'Evento',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${eventoData!['data'] ?? 'Data não informada'} • ${eventoData!['local'] ?? 'Local não informado'}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const Divider(height: 24),
          ...ticketCounts!.entries
              .where((entry) => entry.value > 0)
              .map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${entry.value}x ${entry.key}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          formatPrice(entry.value * (ticketPrices[entry.key] ?? 55.0)),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (${getTotalTickets()} ${getTotalTickets() == 1 ? 'ingresso' : 'ingressos'})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatPrice(totalPrice),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: orange500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String validatorMsg,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: (value) => value == null || value.isEmpty ? validatorMsg : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'sans-serif'),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: orange500),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: orange500),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: orange500, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}