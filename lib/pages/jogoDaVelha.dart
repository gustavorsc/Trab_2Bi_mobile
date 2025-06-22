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
        result = 'Você venceu!';
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
          result = 'Máquina venceu!';
        } else if (!board.contains('')) {
          result = 'Empate!';
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
          border: Border.all(color: Colors.blue.shade300, width: 2),
          color: Colors.grey[900],
        ),
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(
              fontSize: 48,
              color: board[index] == 'X' ? Colors.lightGreenAccent : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela para limitar o tamanho do tabuleiro
    final size = MediaQuery.of(context).size;
    final double boardSize = size.width * 0.9; // 90% da largura da tela

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Jogo da Velha"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: boardSize,
                height: boardSize,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (_, i) => buildCell(i),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                result,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                ),
                child: const Text(
                  "Reiniciar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
