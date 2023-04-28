import 'package:flutter/cupertino.dart';

class MyShroom extends StatelessWidget {
  const MyShroom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("assets/mushroom.png"),
      height: 45,
      width: 45,
    );
  }
}
