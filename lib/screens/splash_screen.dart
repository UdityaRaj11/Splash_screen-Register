import 'package:flutter/material.dart';
import 'package:splash_screen_animation/screens/home_page_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  static const routeName = '/splash_screen';
}

class _SplashScreenState extends State<SplashScreen> {
  double imgHeight = 50;
  double imgWidth = 50;
  double textOpacity = 0;
  bool animate = false;
  double turns = 0.0;
  Color _color = Colors.black;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 3000),
        decoration: BoxDecoration(
          color: _color,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              bottom: animate ? screenHeight / 2 - 100 : 280,
              left: screenWidth / 2 - 100,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 50),
                curve: Curves.ease,
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 600),
                  turns: turns,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: animate ? 1 : 0,
                    child: Center(
                      child: Image(
                        image: const AssetImage('assets/bg.png'),
                        height: imgHeight,
                        width: imgWidth,
                        color: const Color.fromARGB(255, 229, 206, 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight / 2 + 90,
              left: screenWidth / 2 - 70,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: textOpacity,
                child: const Text(
                  'YOUR APP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight / 2 + 125,
              left: screenWidth / 2 - 100,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2500),
                opacity: textOpacity,
                child: const Text(
                  'Your App, Your Style.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 50))
        .then((value) => setState(() {
              animate = true;
              turns += 1.0 / 8.0;
              imgHeight = 200;
              imgWidth = 200;
            }));
    await Future.delayed(const Duration(milliseconds: 1100))
        .then((value) => setState(() {
              textOpacity = 1;
              _color = const Color.fromARGB(255, 76, 55, 47);
            }));
    await Future.delayed(const Duration(milliseconds: 4000));
    Navigator.pushNamed(context, HomePageScreen.routeName);
  }
}
