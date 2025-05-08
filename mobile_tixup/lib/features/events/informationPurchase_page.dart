import 'package:flutter/material.dart';

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
              _sectionTitle("Preencha seus dados", orange500),
              const SizedBox(height: 16),
              _buildTextField(label: "Nome completo", controller: _nameController, validatorMsg: "Informe seu nome"),
              _buildTextField(label: "CPF", controller: _cpfController, validatorMsg: "Informe seu CPF"),
              _buildTextField(label: "E-mail", controller: _emailController, validatorMsg: "Informe seu e-mail", inputType: TextInputType.emailAddress),
              _buildTextField(label: "Telefone", controller: _phoneController, validatorMsg: "Informe seu telefone", inputType: TextInputType.phone),
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
                      //Salvar dados pro supabase
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Compra confirmada!"),
                          content: const Text("Seus ingressos serão enviados por e-mail."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Confirmar Compra",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
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
