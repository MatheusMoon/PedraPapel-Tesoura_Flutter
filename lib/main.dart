import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(PedraPapelTesouraApp());
}

class PedraPapelTesouraApp extends StatefulWidget {
  @override
  _PedraPapelTesouraAppState createState() => _PedraPapelTesouraAppState();
}

class _PedraPapelTesouraAppState extends State<PedraPapelTesouraApp> {
  final List<String> opcoes = ["pedra", "papel", "tesoura"];
  String escolhaUsuario = "";
  String escolhaApp = "";
  String resultado = "Escolha uma opção";
  int vitorias = 0;
  int derrotas = 0;
  int empates = 0;

  void jogar(String escolha) {
    setState(() {
      escolhaUsuario = escolha;
      escolhaApp = opcoes[Random().nextInt(3)];
      resultado = determinarVencedor(escolhaUsuario, escolhaApp);

      if (resultado == "Você venceu!") {
        vitorias++;
      } else if (resultado == "Você perdeu!") {
        derrotas++;
      } else {
        empates++;
      }
    });
  }

  String determinarVencedor(String usuario, String app) {
    if (usuario == app) {
      return "Empate!";
    } else if ((usuario == "pedra" && app == "tesoura") ||
        (usuario == "papel" && app == "pedra") ||
        (usuario == "tesoura" && app == "papel")) {
      return "Você venceu!";
    } else {
      return "Você perdeu!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Pedra, Papel e Tesoura")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placar
            Text(
              "Vitórias: $vitorias | Derrotas: $derrotas | Empates: $empates",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Escolha do usuário e do app
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _exibirImagem(escolhaUsuario),
                SizedBox(width: 30),
                _exibirImagem(escolhaApp),
              ],
            ),

            SizedBox(height: 20),

            // Resultado
            Text(
              resultado,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            // Opções para o usuário escolher
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  opcoes.map((opcao) {
                    return GestureDetector(
                      onTap: () => jogar(opcao),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/images/$opcao.png",
                          width: 80,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _exibirImagem(String escolha) {
    if (escolha.isEmpty) {
      return Container(width: 80, height: 80);
    } else {
      return Image.asset("assets/images/$escolha.png", width: 80);
    }
  }
}
