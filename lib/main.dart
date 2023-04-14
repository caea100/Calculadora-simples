import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String numero = '0';
  double primeiroNumero = 0.0;
  String operacao = '';

  void calcular(String tecla) {
    setState(() {
      if (tecla == 'AC') {
        numero = '0';
        operacao = '';
        primeiroNumero = 0.0;
      } else if (tecla == '<X') {
        if (numero.length == 1) {
          numero = '0';
        } else {
          numero = numero.substring(0, numero.length - 1);
        }
      } else if (tecla == ',') {
        if (!numero.contains(',')) {
          numero += '.';
        }
      } else if (tecla == '+' || tecla == '-' || tecla == 'X' || tecla == '/') {
        operacao = tecla;
        primeiroNumero = double.parse(numero.replaceAll(',', '.'));
        numero = '0';
      } else if (tecla == '=') {
        if (operacao.isNotEmpty) {
          double resultado = 0.0;
          double segundoNumero = double.parse(numero.replaceAll(',', '.'));
          switch (operacao) {
            case '+':
              resultado = primeiroNumero + segundoNumero;
              break;
            case '-':
              resultado = primeiroNumero - segundoNumero;
              break;
            case 'X':
              resultado = primeiroNumero * segundoNumero;
              break;
            case '/':
              resultado = primeiroNumero / segundoNumero;
              break;
            default:
              break;
          }
          numero = resultado.toString().replaceAll('.', ',');
          operacao = '';
        }
      } else {
        if (numero == '0') {
          numero = tecla;
        } else {
          numero += tecla;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Center(
            child: Text('Calculadora'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  numero,
                  style: const TextStyle(fontSize: 75),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('AC'),
                const SizedBox(),
                const SizedBox(),
                buildButton('<X'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('X'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton('0'),
                buildButton(','),
                buildButton('='),
                buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String tecla) {
    return ElevatedButton(
      key: ValueKey(tecla),
      onPressed: () => calcular(tecla),
      child: Text(tecla),
    );
  }
}
