import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_covid/views/World.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..forward();
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const WorldScreen(),
            )));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            child: Center(
                child: SizedBox(
              width: 200,
              height: 200,
              child: Image(image: AssetImage('assets/images/setting.jpg')),
            )),
            animation: controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2.0 * math.pi,
                child: child,
              );
            },
          )
        ],
      )),
    );
  }
}
