import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_mario_game/jumping_mario.dart';
import 'package:super_mario_game/mario.dart';
import 'package:super_mario_game/shrooms.Dart.dart';

import 'button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 60;
  double time = 0;
  double shroomX = 0.7;
  double shroomY = 1;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;
  var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, fontSize: 20));

  void ateShrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY).abs() < 0.05) {
      setState(() {
        shroomX = 2;
        marioSize = 110;
      });
    }
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    preJump();
    midjump = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;
      setState(() {
        marioY = initialHeight - height;
      });
      if (initialHeight - height > 1) {
        setState(() {
          marioY = 1;
          timer.cancel();
          midjump = false;
        });
      } else {
        setState(() {
          marioY = initialHeight - height;
        });
      }
    });
  }

  void moveLeft() {
    direction = "left";
    ateShrooms();
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      ateShrooms();

      if (MyButton().userToHoldingButton() == true && (marioX - 0.02) > -1) {
        setState(() {
          marioX += -0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveRight() {
    direction = "right";
    ateShrooms();
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      ateShrooms();

      if (MyButton().userToHoldingButton() == true && (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: Duration(milliseconds: 0),
                    child: midjump
                        ? JumpingMario(
                            size: marioSize,
                            direction: direction,
                          )
                        : MyMario(
                            size: marioSize,
                            direction: direction,
                            midrun: midrun,
                          ),
                  ),
                ),
                Container(
                  child: MyShroom(),
                  alignment: Alignment(shroomX, shroomY),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("MARIO", style: gameFont),
                          const SizedBox(height: 10),
                          Text(
                            "0000",
                            style: gameFont,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("WORLD", style: gameFont),
                          const SizedBox(height: 10),
                          Text(
                            "1-1",
                            style: gameFont,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("TIME", style: gameFont),
                          const SizedBox(height: 10),
                          Text(
                            "9999",
                            style: gameFont,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
        Expanded(
            child: Container(
          color: Colors.brown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                function: moveLeft,
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              MyButton(
                function: jump,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
              MyButton(
                function: moveRight,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ))
      ],
    ));
  }
}
