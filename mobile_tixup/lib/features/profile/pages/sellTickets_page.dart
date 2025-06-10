import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/sell_tickets_viewmodel.dart';

class TelaVenderIngresso extends StatelessWidget {
  const TelaVenderIngresso({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SellTicketsViewModel(),
      child: const _TelaVenderIngressoBody(),
    );
  }
}

class _TelaVenderIngressoBody extends StatelessWidget {
  const _TelaVenderIngressoBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SellTicketsViewModel>(context);
    final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: laranjaPrincipal,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Vender Ingresso',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'sans-serif',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preencha os detalhes abaixo para publicar seu ingresso:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'sans-serif',
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  _buildCardInput(
                    icon: Icons.event,
                    controller: viewModel.eventoController,
                    label: 'Nome do Evento',
                  ),
                  _buildCardInput(
                    icon: Icons.date_range,
                    controller: viewModel.dataController,
                    label: 'Data do Evento (ex: 24/04/2025)',
                  ),
                  _buildCardInput(
                    icon: Icons.location_on,
                    controller: viewModel.localController,
                    label: 'Local do Evento',
                  ),
                  _buildCardInput(
                    icon: Icons.confirmation_number_outlined,
                    controller: viewModel.tipoIngressoController,
                    label: 'Tipo de Ingresso (ex: VIP, Pista)',
                  ),
                  _buildCardInput(
                    icon: Icons.attach_money,
                    controller: viewModel.precoController,
                    label: 'Preço (R\$)',
                    isNumber: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      viewModel.venderIngresso(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: laranjaPrincipal,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    icon: const Icon(Icons.publish, color: Colors.white),
                    label: const Text(
                      'Publicar Ingresso',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sans-serif',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInput({
    required IconData icon,
    required TextEditingController controller,
    required String label,
    bool isNumber = false,
  }) {
    final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: laranjaPrincipal.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: laranjaPrincipal.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(fontFamily: 'sans-serif'),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: laranjaPrincipal),
          hintText: label,
          hintStyle: const TextStyle(fontFamily: 'sans-serif'),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo é obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
