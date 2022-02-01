// переход между двумя страницами

import 'package:flutter/material.dart';

class NavigationDemo extends StatefulWidget {
  const NavigationDemo({Key? key}) : super(key: key);

  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const MainScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/contacts': (context) => const SecondScreen(),
      },
    );
  }
}

Widget navDraver(context) => Drawer(
  child: ListView(padding: EdgeInsets.zero, children: [
    DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Container(
        height: 200,
      ),
    ),
    ListTile(
      leading: const Icon(Icons.one_k),
      title: const Text('Главная'),
      onTap: () {
        // Navigator.pop(context);
        Navigator.pushNamed(context, '/');
      },
    ),
    ListTile(
      leading: const Icon(Icons.two_k),
      title: const Text('Контакты'),
      onTap: () {
        // Navigator.pop(context);
        Navigator.pushNamed(context, '/contacts');
      },
    ),
  ]),
);

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Главная'),),
      drawer: navDraver(context),
      body: const Center(
        child: Text('Главная страница'),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Контакты'),),
      drawer: navDraver(context),
      body: const Center(
        child: Text('Контакты'),
      ),
    );
  }
}

