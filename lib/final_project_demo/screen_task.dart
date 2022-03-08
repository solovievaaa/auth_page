import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auth_page/final_project_demo/theme_final.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_page/final_project_demo/cont_string.dart';
import 'package:auth_page/final_project_demo/user_class_list.dart';

class TaskMainScreen extends StatelessWidget {
  const TaskMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int userID = ModalRoute.of(context)!.settings.arguments as int;
    return TaskScreen(userID: userID);
  }
}

class TaskScreen extends StatefulWidget {
  final int userID;
  const TaskScreen({Key? key, required this.userID}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  late Future<User> _futureUser;
  late Future<TaskList> _futureTaskList;

  String? _userStoredName;
  String? _userStoredPass;

  bool _checkAuthorization() {
    if ((_userStoredName == Strings.userName)&&(_userStoredPass == Strings.userPass)) {
      return true;
    }
    return false;
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userStoredName = (prefs.getString('userStoredName') ?? '');
      _userStoredPass = (prefs.getString('userStoredPass') ?? '');
    });
  }

  void _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStoredName', (_userStoredName ?? ''));
    prefs.setString('userStoredPass', (_userStoredPass ?? ''));
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _futureUser = fetchSingleUser(widget.userID);
    _futureTaskList = fetchTaskList(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    if (_checkAuthorization()) {
      return Scaffold(
        appBar: myAppBar('Задачи пользователя'),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.userWidget(context);
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
                const SizedBox(height: 5),
                Text("Список задач:", style: Theme.of(context).textTheme.headline6),
                FutureBuilder<TaskList>(
                    future: _futureTaskList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.items.length,
                            itemBuilder:(BuildContext context, int index) {
                              return Container(
                                height: 50,
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(snapshot.data!.items[index].title, style: Theme.of(context).textTheme.bodyText1,)
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          value: snapshot.data!.items[index].completed,
                                          onChanged: (bool? value) {},
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Icon(Icons.verified_user, size: 50, color: Theme.of(context).primaryColor,),
                const SizedBox(height: 50),
                Text('Неверные данные. Доступ запрещен.',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}