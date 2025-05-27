import 'package:flutter/material.dart';

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  void calcularIMC() {
    final double? peso = double.tryParse(pesoController.text);
    final double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      _mostrarResultado('Dados inválidos. Preencha corretamente.');
      return;
    }

    final imc = peso / (altura * altura);
    String resultado = '';

    if (imc < 18.5) {
      resultado = 'Abaixo do peso';
    } else if (imc < 25) {
      resultado = 'Peso normal';
    } else if (imc < 30) {
      resultado = 'Sobrepeso';
    } else {
      resultado = 'Obesidade';
    }

    _mostrarResultado('Seu IMC é ${imc.toStringAsFixed(2)}\n$resultado');
  }

  void _mostrarResultado(String mensagem) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Resultado do IMC'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (m)'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: calcularIMC,
              child: Text('Calcular'),
            )
          ],
        ),
      ),
    );
  }
}
