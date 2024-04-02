import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(RockPaperScissorsApp());
}

class RockPaperScissorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RockPaperScissorsHomePage(),
    );
  }
}

class RockPaperScissorsHomePage extends StatefulWidget {
  @override
  _RockPaperScissorsHomePageState createState() =>
      _RockPaperScissorsHomePageState();
}

class _RockPaperScissorsHomePageState extends State<RockPaperScissorsHomePage> {
  final List<String> choices = ['Rock', 'Paper', 'Scissors'];
  String? userChoice;
  String? computerChoice;
  String? result;
  int userScore = 0;
  int computerScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rock Paper Scissors',
          style: TextStyle(fontSize: 50.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose your move:',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choices.map((choice) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      userChoice = choice;
                      computerChoice = choices[Random().nextInt(3)];
                      result = determineWinner(userChoice!, computerChoice!);
                      updateScores(result!);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/${choice.toLowerCase()}.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        choice,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            if (userChoice != null && computerChoice != null)
              Text(
                'You chose: $userChoice',
                style: TextStyle(fontSize: 20.0),
              ),
            if (computerChoice != null)
              Text(
                'Computer chose: $computerChoice',
                style: TextStyle(fontSize: 20.0),
              ),
            if (result != null)
              Text(
                result!,
                style: TextStyle(fontSize: 20.0),
              ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Scores: You: $userScore, Computer: $computerScore',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String determineWinner(String user, String computer) {
    if (user == computer) {
      return 'It\'s a tie!';
    } else if ((user == 'Rock' && computer == 'Scissors') ||
        (user == 'Paper' && computer == 'Rock') ||
        (user == 'Scissors' && computer == 'Paper')) {
      return 'You win!';
    } else {
      return 'Computer wins!';
    }
  }

  void updateScores(String result) {
    if (result == 'You win!') {
      userScore++;
    } else if (result == 'Computer wins!') {
      computerScore++;
    }
  }
}
