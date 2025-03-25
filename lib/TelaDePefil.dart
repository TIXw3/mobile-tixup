import 'package:flutter/material.dart';

class TelaDePerfil extends StatelessWidget {
  const TelaDePerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'sans-serif',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildUserHeader(context),
            const SizedBox(height: 20),
            _buildInterestAndBalanceSection(context),
            const SizedBox(height: 20),
            _buildOption(
              context,
              'Pedidos',
              Icons.shopping_bag_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Ingressos',
              Icons.confirmation_number,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Carteirinhas',
              Icons.card_membership,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Minha Conta',
              Icons.account_circle_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Meu Endereço',
              Icons.location_on_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Meus Cartões',
              Icons.credit_card_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Tutorial',
              Icons.help_outline,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Suporte',
              Icons.support_agent_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Sair da Conta',
              Icons.exit_to_app_outlined,
              () {},
              size: 10,
            ),
            _buildOption(
              context,
              'Excluir Conta',
              Icons.delete_outline,
              () {},
              size: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Color(0xFFFAF0E6),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(''),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Gabriel Lucas Indio',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'gabrielucasindio@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Editar Perfil',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestAndBalanceSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOption(
          context,
          'Meus Interesses',
          Icons.star_outline,
          () {},
          size: 6,
        ),
        _buildOption(
          context,
          'Seguindo',
          Icons.people_outline,
          () {},
          size: 6,
        ),
        _buildBalance(),
      ],
    );
  }

  Widget _buildBalance() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.deepOrange,
            size: 24,
          ),
          SizedBox(width: 16),
          Text(
            'R\$ 0,00',
            style: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'sans-serif',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon, VoidCallback onTap, {double size = 18}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepOrange, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'sans-serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
