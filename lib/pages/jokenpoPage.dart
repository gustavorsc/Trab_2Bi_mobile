import 'package:flutter/material.dart';
import 'dart:math';

class JokempoPage extends StatefulWidget {
  const JokempoPage({super.key});

  @override
  State<JokempoPage> createState() => _JokempoPageState();
}

class _JokempoPageState extends State<JokempoPage> {
  var _imagemApp = const AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  int _vitoriasUsuario = 0;
  int _vitoriasApp = 0;
  Color _corResultado = Colors.black;

  void _opcaoSelecionada(String escolhaUsuario) {
    if (_vitoriasUsuario == 1 || _vitoriasApp == 1) return;

    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
    });

    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou :)";
        _corResultado = Colors.green;
        _pontosUsuario++;
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu :(";
        _corResultado = Colors.red;
        _pontosApp++;
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente :/";
        _corResultado = Colors.blue;
      });
    }

    if (_pontosUsuario == 4) {
      _vitoriasUsuario++;
      _resultadoFinal = "Você venceu a melhor de 7!";
    } else if (_pontosApp == 4) {
      _vitoriasApp++;
      _resultadoFinal = "Você perdeu a melhor de 7!";
    }
  }

  void _reiniciarJogo() {
    setState(() {
      _pontosUsuario = 0;
      _pontosApp = 0;
      _vitoriasUsuario = 0;
      _vitoriasApp = 0;
      _resultadoFinal = "Boa sorte!!!";
      _imagemApp = const AssetImage("images/padrao.png");
      _corResultado = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: _imagemApp),
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildOpcao("pedra"),
              _buildOpcao("papel"),
              _buildOpcao("tesoura"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _resultadoFinal,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _corResultado),
            ),
          ),
          Text("Usuário: $_pontosUsuario  |  App: $_pontosApp",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          if (_vitoriasUsuario == 1 || _vitoriasApp == 1)
            ElevatedButton(
              onPressed: _reiniciarJogo,
              child: const Text("Recomeçar"),
            ),
        ],
      ),
    );
  }

  Widget _buildOpcao(String opcao) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _opcaoSelecionada(opcao),
          child: Image(image: AssetImage('images/$opcao.png'), height: 100),
        ),
        const SizedBox(height: 5),
        Text(opcao.toUpperCase(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
