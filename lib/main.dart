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
        backgroundColor: Color.fromARGB(255, 17, 16, 16),
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
                  style: const TextStyle(fontSize: 75, color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botaoGenerico('AC'),
                const SizedBox(),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => calcular('<X'),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botaoGenerico('7'),
                botaoGenerico('8'),
                botaoGenerico('9'),
                botaoGenerico('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botaoGenerico('4'),
                botaoGenerico('5'),
                botaoGenerico('6'),
                botaoGenerico('X'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botaoGenerico('1'),
                botaoGenerico('2'),
                botaoGenerico('3'),
                botaoGenerico('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                botaoGenerico('0'),
                botaoGenerico(','),
                botaoGenerico('='),
                botaoGenerico('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoGenerico(String tecla) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      key: ValueKey(tecla),
      onPressed: () => calcular(tecla),
      child: Text(tecla),
    );
  }
}