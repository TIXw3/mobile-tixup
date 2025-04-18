import 'package:flutter/material.dart';

class TelaVenderIngresso extends StatefulWidget {
  const TelaVenderIngresso({super.key});

  @override
  State<TelaVenderIngresso> createState() => _TelaVenderIngressoState();
}

class _TelaVenderIngressoState extends State<TelaVenderIngresso> {
  final Color laranjaPrincipal = const Color.fromARGB(255, 249, 115, 22);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _eventoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _tipoIngressoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  @override
  void dispose() {
    _eventoController.dispose();
    _dataController.dispose();
    _localController.dispose();
    _tipoIngressoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _venderIngresso() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ingresso publicado com sucesso!'),
          backgroundColor: laranjaPrincipal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              key: _formKey,
              child: Column(
                children: [
                  _buildCardInput(
                    icon: Icons.event,
                    controller: _eventoController,
                    label: 'Nome do Evento',
                  ),
                  _buildCardInput(
                    icon: Icons.date_range,
                    controller: _dataController,
                    label: 'Data do Evento (ex: 24/04/2025)',
                  ),
                  _buildCardInput(
                    icon: Icons.location_on,
                    controller: _localController,
                    label: 'Local do Evento',
                  ),
                  _buildCardInput(
                    icon: Icons.confirmation_number_outlined,
                    controller: _tipoIngressoController,
                    label: 'Tipo de Ingresso (ex: VIP, Pista)',
                  ),
                  _buildCardInput(
                    icon: Icons.attach_money,
                    controller: _precoController,
                    label: 'Preço (R\$)',
                    isNumber: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _venderIngresso,
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
