import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder/tinder_card.dart';

import 'models/user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (const CupertinoApp(
      title: 'Flutter Tinder',
      theme: CupertinoThemeData(
          // primaryColor: Colors.pink,
          ),
      home: MainPage(),
    ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = const User(
    name: 'John Doe',
    age: 30,
    urlImage: 'https://picsum.photos/1000?image=',
  );

  Widget buildLogo() {
    return const Row(
      children: [
        Icon(Icons.local_fire_department_rounded,
            color: Colors.white, size: 36),
        SizedBox(width: 4),
        Text("Tinder",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget buildButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CupertinoButton(
        onPressed: () {},
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        child: const Icon(Icons.clear, color: Colors.red, size: 36),
      ),
      CupertinoButton(
        onPressed: () {},
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        child: const Icon(Icons.favorite, color: Colors.green, size: 36),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade200, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  buildLogo(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TinderCard(user: user),
                  ),
                  const SizedBox(height: 16),
                  buildButtons()
                ]))),
      ),
    );
  }
}
