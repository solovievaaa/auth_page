import 'dart:async';
import 'dart:convert';
// получение данных из интернета
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // после as псевдоним пакета

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) { // метод конвертации (порождает об)
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class NetworkingScreen extends StatefulWidget {
  const NetworkingScreen({Key? key}) : super(key: key);

  @override
  _NetworkingScreenState createState() => _NetworkingScreenState();
}

class _NetworkingScreenState extends State<NetworkingScreen> {
  late Future<Album> futureAlbum;

  @override
  void initState() { // стандарт метод инициалицазии состояния и первичной настройки
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) { // snapshot позволяет обратиться к данным, полученным из сети
              if (snapshot.hasData) { // проверяет, загружены ли данные
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

/* шаги: (отдельно добавить в андроид.манифест разрешение на доступ к интернет)
1. импорт пакета http и прописать зависимость;
2. выполнить запрос с помощью этого пакета по опред адресу
3. сконвертировать данные в объект дарт
4. отобразить данные на экране
 */