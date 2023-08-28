import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

  var currentplayer = 'X';

  void drawxo(i) {
    if (grid[i] == '-') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });
      findWinner(grid[i]);
    }
  }

  void reset() {
    setState(() {
      winner = '';
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  var winner = '';

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findWinner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
            checkMove(3, 4, 5, currentsign) ||
            checkMove(6, 7, 8, currentsign) ||
            checkMove(0, 3, 6, currentsign) ||
            checkMove(1, 4, 7, currentsign) ||
            checkMove(2, 5, 8, currentsign) ||
            checkMove(0, 4, 8, currentsign) ||
            checkMove(2, 4, 6, currentsign) //diagonal
        ) {
      setState(() {
        winner = currentsign;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          children: [
            if (winner != '')
              Text(
                '$winner won the game',
                style: TextStyle(fontSize: 30.0),
              ),
            Container(
              constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
              margin: EdgeInsets.all(20),
              color: Colors.black,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: grid.length,
                itemBuilder: (context, index) => Material(
                  color: Colors.amber,
                  child: InkWell(
                      splashColor: Colors.black,
                      onTap: () {
                        drawxo(index);
                      },
                      child: Center(
                          child: Text(
                        grid[index],
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ))),
                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  reset();
                },
                icon: Icon(Icons.refresh),
                label: Text('Play Again'))
          ],
        ),
      ),
    );
  }
}
