import 'package:flutter/material.dart';

ThemeData myTheme() => ThemeData(
  primarySwatch: Colors.deepPurple,
  textTheme:const TextTheme(
    headline6: TextStyle(
      fontSize: 24,
      fontFamily: 'Arial',
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontFamily: 'Arial',
    ),
  ),
);

InputDecoration textFieldDecoration(String label, BuildContext context) => InputDecoration(
  filled: true,
  fillColor: Theme.of(context).backgroundColor.withAlpha(100),
  labelText: label,
);

AppBar myAppBar(String myTitle) => AppBar(
  title: Text(myTitle),
);

Widget navDrawer(context) => Drawer(
  child: ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text('Страница авторизации'),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: const Icon(Icons.perm_identity),
        title: const Text('Список пользователей'),
        onTap: () {
          Navigator.pushNamed(context, '/users');
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Настройки профиля'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.help_outline),
        title: const Text('Поддержка'),
        onTap: () {},
      ),
    ],
  ),
);