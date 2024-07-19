// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:animation_create/box_animation_view.dart';
import 'package:animation_create/line_animation_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Animation',
      home: 1 == 1 ? AnimatedLineAndBorder() : HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isAnimation1Show = false;
  bool isAnimation2Show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => setState(() => isAnimation1Show = !isAnimation1Show),
              child: Text("Show Animation"),
            ),
          ),
          Positioned(
            top: 600,
            left: 110,
            child: Container(
              color: Colors.transparent,
              width: 200,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.network("https://oceanmtech.b-cdn.net/dmt/data_file/20240619173057-bzwax9.jpg"),
            ),
          ),
          Positioned(
            top: 50,
            left: 110,
            child: Container(
              color: Colors.transparent,
              width: 200,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.network("https://oceanmtech.b-cdn.net/dmt/data_file/20240619173057-bzwax9.jpg"),
            ),
          ),
          isAnimation1Show
              ? BoxAnimationView(
                  borderColor: Colors.lightBlue.shade900,
                  onTapForBarier: () => setState(() => isAnimation1Show = false),
                  onTapForBox: () {
                    isAnimation2Show = true;
                    isAnimation1Show = false;
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.lightBlue.shade900, fontSize: 15, fontWeight: FontWeight.bold),
                  xPos: 110,
                  yPos: 600 - 70,
                  text: "Tap on",
                )
              : const SizedBox.shrink(),
          isAnimation2Show
              ? BoxAnimationView(
                  borderColor: Colors.lightBlue.shade900,
                  onTapForBarier: () => setState(() => isAnimation2Show = false),
                  onTapForBox: () {
                    isAnimation2Show = false;
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.lightBlue.shade900, fontSize: 15, fontWeight: FontWeight.bold),
                  xPos: 110,
                  yPos: 50,
                  text: "Tap on",
                  isTopText: false,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
