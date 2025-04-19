import 'package:flutter/material.dart';

class TelaTutorial extends StatelessWidget {
  TelaTutorial({Key? key}) : super(key: key);

  final Color orange500 = const Color.fromARGB(255, 249, 115, 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          _buildHeader('Como usar o app'),
          SizedBox(height: 20),
          _buildStep(
            Icons.confirmation_number_outlined,
            'Comprar Ingressos',
            'Navegue até a aba de pesquisa, escolha um evento e clique em "Comprar Ingresso".',
          ),
          SizedBox(height: 25),
          _buildStep(
            Icons.favorite_border,
            'Favoritar Eventos',
            'Use o coração para salvar eventos que você gostou. Eles aparecem na aba "Favoritos".',
          ),
          SizedBox(height: 25),
          _buildStep(
            Icons.account_balance_wallet_outlined,
            'Consultar seu saldo',
            'Vá até a aba "Saldo" no seu perfil e veja todo o seu histórico.',
          ),
          SizedBox(height: 40),
          _buildHeader('Perguntas Frequentes'),
          SizedBox(height: 20),
          _buildFAQ(
            'Onde encontro meus ingressos?',
            'Você pode acessá-los na opção "Meus Ingressos" dentro do seu perfil.',
          ),
          _buildFAQ(
            'Posso cancelar uma compra?',
            'Depende do organizador. Verifique os termos do evento antes da compra.',
          ),
          _buildFAQ(
            'Como adiciono uma forma de pagamento?',
            'No menu do perfil, selecione "Meus Cartões" e adicione seus dados.',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: orange500,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'sans-serif',
      ),
    );
  }

  Widget _buildStep(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 36, color: orange500),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: orange500,
                    fontFamily: 'sans-serif',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'sans-serif',
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontFamily: 'sans-serif',
            ),
          ),
        ),
      ],
      iconColor: orange500,
      collapsedIconColor: orange500,
    );
  }
}
