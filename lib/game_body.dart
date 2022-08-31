// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tictac_game/models.dart';

class GameBody extends StatefulWidget {
  const GameBody({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GameBody> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GameBody> {
  bool twoPlayers = true;
  String player = "X";
  bool gameOver = false;
  String ruselt = "";
  int turn = 0;
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    //double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: const Color.fromRGBO(0, 5, 23, 1),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? Column(
                    children: [
                      ...firstPart(context),
                      Expanded(child: gameBody(context)),
                      ...finalPart(context, screenW)
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: gameBody(context)),
                      Expanded(
                        child: Column(
                          children: [
                            ...firstPart(context),
                            Spacer(),
                            ...finalPart(context, screenW)
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  List firstPart(context) {
    return [
      SwitchListTile(
        value: twoPlayers,
        onChanged: (value) {
          setState(() {
            twoPlayers = value;
          });
        },
        title: const Text(
          "Turn on/of tow player mode",
          overflow: TextOverflow.ellipsis,
          //textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Colors.white),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      if (!gameOver)
        Text(
          "IT,S TURN ! $player",
          style: TextStyle(fontSize: 20),
        )
    ];
  }

  Widget gameBody(context) {
    return GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1 / 1,
        children: List.generate(9, (index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(9, 22, 79, 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: TextButton(
                child: Text(
                  Player.playerX.contains(index)
                      ? "X"
                      : Player.playerO.contains(index)
                          ? "O"
                          : "",
                  style: TextStyle(
                      fontSize: 30,
                      color: (Player.playerX.contains(index))
                          ? Colors.blue
                          : Colors.amber),
                ),
                onPressed: gameOver
                    ? null
                    : () {
                        onTap(index);
                      },
              ),
            ),
          );
        }));
  }

  List<Widget> finalPart(context, screenW) {
    return [
      if (gameOver)
        Text(
          ruselt == "" ? "NO WINNER TRY AGIN" : '$ruselt IS THE WINNER',
          style: TextStyle(fontSize: 20),
        ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenW * 0.05),
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.refresh_sharp),
              FittedBox(
                child: Text(
                  "RESTART THE GAME",
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              player = "X";
              gameOver = false;
              ruselt = "";
              turn = 0;
              //twoPlayers = false;
              Player.playerO = [];
              Player.playerX = [];
            });
          },
        ),
      )
    ];
  }

  onTap(int index) async {
    if (!Player.playerO.contains(index) && !Player.playerX.contains(index)) {
      game.playGame(index, player);
      update();
    }

    if (!twoPlayers && !gameOver) {
      await game.autoPlay(player);
      update();
    }
  }

  void update() {
    setState(() {
      player = (player == "X") ? "O" : "X";
    });
    String w = game.checkWinner();
    if (w != "") {
      setState(() {
        gameOver = true;
        ruselt = w;
      });
    } else if (Player.playerO.length + Player.playerX.length == 9) {
      setState(() {
        gameOver = true;
        ruselt = "";
      });
    }
  }
}
