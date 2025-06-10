import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/edit_profile_viewmodel.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: const _EditProfileBody(),
    );
  }
}

class _EditProfileBody extends StatelessWidget {
  const _EditProfileBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditProfileViewModel>(context);
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
          key: viewModel.formKey,
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
                    backgroundImage: viewModel.profileImage != null ? FileImage(viewModel.profileImage!) : null,
                    child: viewModel.profileImage == null
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
                  onPressed: () => viewModel.selecionarImagem(context),
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
                initialValue: viewModel.nome,
                decoration: _inputDecoration('Nome', Icons.person),
                validator: (value) => value == null || value.isEmpty ? 'Digite seu nome' : null,
                onChanged: (value) => viewModel.nome = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: viewModel.email,
                decoration: _inputDecoration('E-mail', Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value == null || !value.contains('@') ? 'Digite um e-mail válido' : null,
                onChanged: (value) => viewModel.email = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: viewModel.numero,
                decoration: _inputDecoration('Número de Celular', Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.length < 10 ? 'Digite um número válido' : null,
                onChanged: (value) => viewModel.numero = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: viewModel.endereco,
                decoration: _inputDecoration('Endereço', Icons.house),
                validator: (value) => value == null || value.isEmpty ? 'Digite seu endereço' : null,
                onChanged: (value) => viewModel.endereco = value,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (viewModel.formKey.currentState!.validate()) {
                    await viewModel.salvarDadosPerfil();
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
