import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;

  String nome = '';
  String email = '';
  String numero = '';
  String endereco = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _carregarDadosPerfil();
  }

  Future<void> _carregarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome') ?? 'Lucas Gabriel';
      email = prefs.getString('email') ?? 'email@email.com';
      numero = prefs.getString('numero') ?? '(44) 99999-0000';
      endereco = prefs.getString('endereco') ?? 'Rua X, Jardim Y, 89898993';
      final caminhoImagem = prefs.getString('imagemPerfil');
      if (caminhoImagem != null) {
        _profileImage = File(caminhoImagem);
      }
    });
  }

  Future<void> _salvarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nome);
    await prefs.setString('email', email);
    await prefs.setString('numero', numero);
    await prefs.setString('endereco', endereco);
    if (_profileImage != null) {
      await prefs.setString('imagemPerfil', _profileImage!.path);
    }
  }

  Future<void> _selecionarImagem() async {
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha uma opção'),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await _picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, image);
            },
            child: const Text('Galeria'),
          ),
          TextButton(
            onPressed: () async {
              final image = await _picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, image);
            },
            child: const Text('Câmera'),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 249, 115, 22),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Editar Perfil',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color.fromARGB(255, 250, 233, 215),
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _selecionarImagem,
                  icon: const Icon(Icons.photo_camera, color: Colors.white),
                  label: const Text(
                    'Selecionar Imagem',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: nome,
                decoration: _inputDecoration('Nome', Icons.person),
                validator: (value) => value == null || value.isEmpty ? 'Digite seu nome' : null,
                onChanged: (value) => nome = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: email,
                decoration: _inputDecoration('E-mail', Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@') ? 'Digite um e-mail válido' : null,
                onChanged: (value) => email = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: numero,
                decoration: _inputDecoration('Número de Celular', Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.length < 10 ? 'Digite um número válido' : null,
                onChanged: (value) => numero = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: endereco,
                decoration: _inputDecoration('Endereço', Icons.house),
                validator: (value) => value == null || value.isEmpty ? 'Digite seu endereço' : null,
                onChanged: (value) => endereco = value,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _salvarDadosPerfil();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
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
      labelStyle: const TextStyle(
        color: Color.fromARGB(206, 0, 0, 0),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: Color.fromARGB(255, 249, 115, 22)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(206, 0, 0, 0),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 249, 115, 22),
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}
