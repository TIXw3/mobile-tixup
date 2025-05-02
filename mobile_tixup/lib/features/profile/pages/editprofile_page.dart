import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = 'Lucas Gabriel';
  String email = 'email@email.com';
  String phone = '(11) 99999-9999';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromARGB(255, 240, 228, 211),
                  backgroundImage: NetworkImage(''), // URL da imagem atual
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),

              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.photo_camera, color: Color.fromARGB(255, 249, 115, 22)),
                  label: const Text(
                    'Selecionar Imagem',
                    style: TextStyle(
                      color: Color.fromARGB(255, 249, 115, 22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color.fromARGB(255, 249, 115, 22)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextFormField(
                initialValue: name,
                decoration: _inputDecoration('Nome', Icons.person),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite seu nome' : null,
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 20),

              TextFormField(
                initialValue: email,
                decoration: _inputDecoration('E-mail', Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || !value.contains('@') ? 'Digite um e-mail válido' : null,
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 20),

              TextFormField(
                initialValue: phone,
                decoration: _inputDecoration('Número de Celular', Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.length < 10 ? 'Digite um número válido' : null,
                onChanged: (value) => phone = value,
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 249, 115, 22)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 249, 115, 22)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
