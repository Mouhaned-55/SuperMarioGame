import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;
  static bool holdingButton = false;

  const MyButton({Key? key, this.child, this.function}) : super(key: key);

  bool userToHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        holdingButton = false;
      },
      onTapDown: (details) {
        holdingButton = true;
        function();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
