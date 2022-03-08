import 'package:flutter/material.dart';
import 'package:auth_page/final_project_demo/screen_task.dart';
import 'package:auth_page/final_project_demo/screen_start.dart';
import 'package:auth_page/final_project_demo/theme_final.dart';
import 'package:auth_page/final_project_demo/user_screen.dart';

void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RegScreen(),
        '/users': (context) => const UserScreen(),
        '/tasks': (context) => const TaskMainScreen(),
      },
      title: 'Заголовок',
      theme: myTheme(),
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// figma дает по макету номер цвета, размер отступов и тд
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
            width: double.infinity, // позволяет выравнять по центру в строке ??
            child: Column(children: [ // здесть мог бы быть модификатор const
              SizedBox(height: 60,), // отступ картинки от верхней границы, по общему правилу сверху слева
              SizedBox(width: 110, height: 84, child: Placeholder(),), // место для картинки с заданными размерами + место задано пустым
              SizedBox(height: 20,), // отступ текста от картинки
              Text('Введите логин в виде 10 цифр номера телефона'),
              SizedBox(height: 20,), // отступ поля для ввода от текста; по общему правилу занимает всю сторку
              const SizedBox(width: 224, // ширина строки-поля для ввода
                child: TextField( // в скобках настройк стиля
                  decoration: InputDecoration( // вводим стиль, задаем
                    filled: true, // является ли поле заполненным
                    fillColor: Colors.white54, // либо Color(0xFFeceff1), если есть код цвета
                    labelText: 'Телефон', // подсказка, что нужно ввести
                  ),
                ),
              ),
              SizedBox(height: 20,),
              const SizedBox(width: 224,
                child: TextField(
                  obscureText: true, // скрывает текст пароля звездочками,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    labelText: 'Пароль',
                  ),
                ),
              ),
              SizedBox(height: 28,), // saizedbox позволяет задать размер кнопки
              SizedBox(width: 154, height: 42, child: ElevatedButton(onPressed: () {}, child: Text('Войти'))), // задает метод, вызываемый при нажатии на кнопку и надпись на кнопке
              SizedBox(height: 62,),
              InkWell(child: Text('Регистрация'), onTap: () {} ), // добавляет ссылку этот виджет
              // () {} дадут ошибку, метод и значение в константе не могут быть пустыми (если убрать const, кнопка станет активной)
              SizedBox(height: 20,),
              InkWell(child: Text('Забыли пароль?'), onTap: () {} ), // если не обернуть в вижет через alt+enter не прокатит
            ],),
          )
      ),
    );
  }
}

// красное подчеркивание - ошибка (нет запятых - ошибка, например)
желтое подчеркивание - предупреждение (типа ты уверен, что так надо? через правую кнопку мыши можно увидеть предложения приложения)
когда виджит объявляется как константа, не меняется в приложении, его не нужно "перерисовывать",
это влияет на производительность (повышает ее, раз не надо "думать заново каждый раз"
было желтое подчеркивание в виджете children - через add constant ввели константой виджет, подчеркивание ушло
 */
