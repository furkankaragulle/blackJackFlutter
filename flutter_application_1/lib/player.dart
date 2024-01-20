// main.dart
import 'package:flutter/material.dart';
import 'blackjack_game.dart';
import 'card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BlackjackGame game = BlackjackGame();
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      game.startGame();
      gameOver = false;
    });
  }

  void hit() {
    setState(() {
      game.hit(game.player);
      if (game.player.calculateScore() > 21) {
        gameOver = true;
      }
    });
  }

  void stand() {
    setState(() {
      game.stand();
      gameOver = true;
    });
  }

  void startGame() {
    setState(() {
      game.startGame(); // Oyunu başlat
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blackjack Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Oyun durumu
          Text('Game Over: $gameOver', style: TextStyle(fontSize: 24)),

          // Oyuncu kartları
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                game.player.hand.map((card) => MyCardWidget(card)).toList(),
          ),

          // Butonlar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: gameOver ? startGame : null,
                child: Text('Start Game'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: gameOver ? null : hit,
                child: Text('Hit'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: gameOver ? null : stand,
                child: Text('Stand'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Örnek kart widget'ı
class MyCardWidget extends StatelessWidget {
  final MyCard card;

  const MyCardWidget(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: Text('${card.suit} ${card.rank}', style: TextStyle(fontSize: 20)),
    );
  }
}
