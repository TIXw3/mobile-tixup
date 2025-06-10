import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/balance_viewmodel.dart';

class SaldoPage extends StatelessWidget {
  const SaldoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BalanceViewModel(),
      child: const _SaldoPageBody(),
    );
  }
}

class _SaldoPageBody extends StatelessWidget {
  const _SaldoPageBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BalanceViewModel>(context);
    final Color orange500 = const Color.fromARGB(255, 249, 115, 22);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      appBar: AppBar(
        backgroundColor: orange500,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saldo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'sans-serif',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Meu Histórico de Saldo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: orange500,
                  fontFamily: 'sans-serif',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Suas entradas e saídas do seu saldo irão aparecer aqui!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'sans-serif',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: orange500, width: 1.5),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.money_off_csred_outlined,
                      color: orange500,
                      size: 60,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Você ainda não possui saldo na sua conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'sans-serif',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}