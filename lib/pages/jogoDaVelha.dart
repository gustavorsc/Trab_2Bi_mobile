import 'package:flutter/material.dart';
import 'dart:math';

class JogoDaVelhaPage extends StatefulWidget {
  const JogoDaVelhaPage({super.key});

  @override
  State<JogoDaVelhaPage> createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  List<String> board = List.filled(9, '');
  bool isPlayerTurn = true;
  String result = '';

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isPlayerTurn = true;
      result = '';
    });
  }

  void playMove(int index) {
    if (board[index] != '' || result != '') return;

    setState(() {
      board[index] = 'X';
      if (checkWinner('X')) {
        result = 'Parabéns! Você venceu :)';
        return;
      }
      isPlayerTurn = false;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!board.contains('') || result != '') return;

      int move = getMachineMove();
      setState(() {
        board[move] = 'O';
        if (checkWinner('O')) {
          result = 'Puxa! A máquina venceu :(';
        } else if (!board.contains('')) {
          result = 'Empate! Tente novamente :/';
        }
        isPlayerTurn = true;
      });
    });
  }

  int getMachineMove() {
    List<int> available = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') available.add(i);
    }
    return available[Random().nextInt(available.length)];
  }

  bool checkWinner(String player) {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var win in wins) {
      if (board[win[0]] == player &&
          board[win[1]] == player &&
          board[win[2]] == player) {
        return true;
      }
    }
    return false;
  }

  Widget buildCell(int index) {
    return GestureDetector(
      onTap: () => playMove(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(
              fontSize: 48,
              color: board[index] == 'X' ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // mesmo fundo do jokenpo
      appBar: AppBar(
        title: const Text("Jogo da Velha"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Clique para jogar contra a máquina!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (_, i) => buildCell(i),
          ),
          const SizedBox(height: 20),
          Text(
            result,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text("Recomeçar"),
          ),
        ],
      ),
    );
  }
}
