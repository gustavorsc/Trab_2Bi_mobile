import 'package:flutter/material.dart';
import 'package:jokenpo/pages/jokenpoPage.dart';
import 'package:jokenpo/pages/jogoDaVelha.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/jokempo': (context) => const JokempoPage(),
      '/jogo-da-velha': (context) => const JogoDaVelhaPage(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jogos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/jokempo'),
              child: const Text("JokenPo"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/jogo-da-velha'),
              child: const Text("Jogo da Velha"),
            ),
          ],
        ),
      ),
    );
  }
}
