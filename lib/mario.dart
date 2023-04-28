import 'dart:math';

import 'package:flutter/cupertino.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrun;
  final size ;

  const MyMario({Key? key, this.direction, this.midrun, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: size,
        height: size,
        child: midrun
            ? Image.asset("assets/mario_st.png")
            : Image.asset("assets/mario_run.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midrun
              ? Image.asset("assets/mario_st.png")
              : Image.asset("assets/mario_run.png"),
        ),
      );
    }
  }
}
