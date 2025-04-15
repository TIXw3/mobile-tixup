import 'package:flutter/material.dart';

class SeguindoPage extends StatefulWidget {
  const SeguindoPage({Key? key}) : super(key: key);

  @override
  State<SeguindoPage> createState() => _SeguindoPageState();
}

class _SeguindoPageState extends State<SeguindoPage> {
  final Color orange500 = const Color.fromARGB(255, 249, 115, 22);

  String selectedOrder = 'A-Z';

  final List<Map<String, String>> organizadores = [
    {'nome': 'BUTIQUIM', 'descricao': 'É o Butica da galera!'},
    {'nome': 'FILIN', 'descricao': 'Única e Surpreendente!'},
  ];

  List<Map<String, String>> getOrganizadoresOrdenados() {
    List<Map<String, String>> sorted = List.from(organizadores);
    switch (selectedOrder) {
      case 'A-Z':
        sorted.sort((a, b) => a['nome']!.compareTo(b['nome']!));
        break;
      case 'Z-A':
        sorted.sort((a, b) => b['nome']!.compareTo(a['nome']!));
        break;
      case 'Mais Recentes':
        sorted = sorted.reversed.toList();
        break;
      case 'Mais Antigos':
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final organizadoresOrdenados = getOrganizadoresOrdenados();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: orange500,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
              Center(
                child: Icon(
                  Icons.confirmation_number_outlined,
                  size: 80,
                  color: orange500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Organizações Seguidas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: orange500,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Os organizadores que você segue irão aparecer aqui!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Ordenar por',
                      style: TextStyle(
                        fontSize: 18,
                        color: orange500,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedOrder,
                      items:
                          <String>[
                            'A-Z',
                            'Z-A',
                            'Mais Recentes',
                            'Mais Antigos',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'sans-serif',
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedOrder = newValue!;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'sans-serif',
                      ),
                      iconEnabledColor: orange500,
                      dropdownColor: Colors.white,
                      underline: Container(height: 2, color: orange500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: organizadoresOrdenados.length,
                  itemBuilder: (context, index) {
                    final org = organizadoresOrdenados[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: orange500, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            org['nome']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: orange500,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            org['descricao']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
