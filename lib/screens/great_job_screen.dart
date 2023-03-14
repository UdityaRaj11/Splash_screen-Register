import 'package:flutter/material.dart';

class GreatJobScreen extends StatelessWidget {
  static const routeName = '/great-job';
  const GreatJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 76, 55, 47),
      body: Center(
        child: Text(
          'Great Job!!',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 229, 206, 0),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
