import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uiflags/flags_guess_game/data.dart';

import 'package:uiflags/main.dart';

class Flagss extends StatefulWidget {
  const Flagss({Key? key}) : super(key: key);

  @override
  State<Flagss> createState() => _FlagssState();
}

class _FlagssState extends State<Flagss> {
  int rhealth = 3;
  int rscore = 0;
  int rtotalq = 0;
  bool selected = false;
  bool canceltimer = false;
  String showtimer = '10';

  int ran1 = Random().nextInt(7);
  int ran2 = Random().nextInt(7) + 1;
  int timer = 10;

  List<Color> borderColor = [
    Colors.transparent,
    Colors.green,
    Colors.red,
  ];

  optionss(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 150,
        child: MaterialButton(
          onPressed: () => checkans(i),
          child: flaglist[ran1 + i][countryName[ran1 + i]],
          color: Colors.transparent,
          splashColor: Colors.orange[50],
        ),
      ),
    );
  }

  nextQues() {
    setState(() {
      rscore++;
      rtotalq++;
      (ran1 > 7) ? ran1 = ran1 - ran2 - 1 : ran1 = ran1 + 1;
    });

    if (rtotalq >= 8) {
      gameoverdialogue();
    }
  }

  checkans(int i) {
    var a = '(' + countryName[ran1] + ')';
    var b = flaglist[ran1 + i].keys.toString();
    if (a == b) {
      nextQues();
    } else {
      setState(() {
        rhealth--;
      });

      checkifgameover(rhealth);
    }
  }

  checkifgameover(int heal) {
    if (heal <= 0) {
      gameoverdialogue();
    }
  }

  gameoverdialogue() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                'Game Over',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              content: Text(
                'Your score was $rscore/8',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Flagss()));
                    },
                    child: const Text('Play Again')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    },
                    child: const Text('Back To Home')),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    //list of 4 iterations of a function
    //we shuffle to make sure the ans is not always on the same place
    List option = [
      optionss(0),
      optionss(1),
      optionss(2),
      optionss(3),
    ];

    option.shuffle();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Guess the flag'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            children: [
              //for question

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      showtimer,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  Text(
                    countryName[ran1],
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  option[0],
                  option[1],
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  option[2],
                  option[3],
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        'remaining health: $rhealth',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        'your score: $rscore',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
