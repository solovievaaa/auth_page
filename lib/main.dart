import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// figma (сайт) дает по макету номер цвета, размер отступов и тд
  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(36)), // радиус округления (.круглый, радиус округления 36
      borderSide: BorderSide( // цвет рамки, только самой рамки
        color: const Color(0xFFbbbbbb), width: 2));
    const linkTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0079D0)
    ); // задали стиль текста кнопок как отдельную константу, чтобы не дублировать куски кода

    return MaterialApp(
      home: Scaffold(
          body: Container(
            decoration: const BoxDecoration( // настройка изорбражения фона
              image: DecorationImage(
                image: AssetImage('assets/original_oboi.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity, // позволяет выравнять по центру в строке ??
            child: Column(children: [ // здесть мог бы быть модификатор const
              SizedBox(height: 60,), // отступ картинки от верхней границы, по общему правилу сверху слева
              const SizedBox(width: 110, height: 84, child: Image(image: AssetImage('assets/dart1.jpg')),), // настройка изорбражения, тут было место для картинки с заданными размерами + место задано пустым
              SizedBox(height: 20,), // отступ текста от картинки
              Text('Введите логин в виде 10 цифр номера телефона',
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),),
              SizedBox(height: 20,), // отступ поля для ввода от текста; по общему правилу занимает всю сторку
              const SizedBox(width: 224, // ширина строки-поля для ввода
                child: TextField( // в скобках настройк стиля
                  decoration: InputDecoration( // вводим стиль, задаем
                    filled: true, // является ли поле заполненным
                    fillColor: Color(0xFFeceff1), // либо Color(0xFFeceff1) либо colors.blue, если есть код цвета
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    labelText: 'Телефон', // подсказка в поле для ввода, что нужно ввести
                  ),
                ),
              ),
              SizedBox(height: 20,),
              const SizedBox(width: 224,
                child: TextField(
                  obscureText: true, // скрывает текст пароля звездочками,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFeceff1),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    labelText: 'Пароль',
                  ),
                ),
              ),
              SizedBox(height: 28,), // saizedbox позволяет задать размер кнопки
              SizedBox(width: 154, height: 42, child:
              ElevatedButton(onPressed: () {},
                  child: Text('Войти'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0079D0), // цвет кнопки, где FF - значение прозрачности, здесь непрозрачная
                    shape: RoundedRectangleBorder( // скругленный прямоугольник
                      borderRadius: BorderRadius.circular(36.0), // значение скругления
                )
              )
          )
      ), // задает метод, вызываемый при нажатии на кнопку и надпись на кнопке
              SizedBox(height: 32,),
              InkWell(child: const Text('Регистрация', style: linkTextStyle,),
                  onTap: () {} ), // добавляет ссылку этот виджет
              // () {} дадут ошибку, метод и значение в константе не могут быть пустыми (если убрать const, кнопка станет активной)
              SizedBox(height: 20,),
              InkWell(child: const Text('Забыли пароль?', style: linkTextStyle,),
                  onTap: () {} ), // если не обернуть в вижет через alt+enter не прокатит
            ],),
          )
      ),
    );
  }
}

// красное подчеркивание - ошибка (нет запятых - ошибка, например)
/* желтое подчеркивание - предупреждение (типа ты уверен, что так надо? через правую кнопку мыши можно увидеть предложения приложения)
когда виджит объявляется как константа, не меняется в приложении, его не нужно "перерисовывать",
это влияет на производительность (повышает ее, раз не надо "думать заново каждый раз"
было желтое подчеркивание в виджете children - через add constant ввели константой виджет, подчеркивание ушло
 enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                      borderSide: BorderSide(
                        color: const Color(0xFFeceff1), width: 2)),
                    focusedBorder: , можно скопировать предыдущие 4 строки либо обращаться к переменной OutlineInputBorder
 */