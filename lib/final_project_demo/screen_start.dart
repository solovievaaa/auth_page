import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_page/final_project_demo/theme_final.dart';
import 'package:auth_page/final_project_demo/cont_string.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _userStoredName;
  String? _userStoredPass;

  bool _checkAuthorization() {
    if ((_userStoredName == Strings.userName)&&(_userStoredPass == Strings.userPass)) {
      return true;}
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
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_checkAuthorization()) {
      return Scaffold(
        appBar: myAppBar('Итоговый проект'),
        drawer: navDrawer(context),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(width: 280, height: 180, child: Image(image: AssetImage('assets/unicorn_2.png')),),

                Row(
                  children: const [
                    Expanded(child: SizedBox(height: 20)),
                  ],
                ),

                Text('Вход выполнен успешно',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 170,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: (){
                      _userStoredName ='';
                      _userStoredPass ='';
                      _saveUserData();
                      setState(() {});
                    },
                    child: const Text('Покинуть профиль', textAlign: TextAlign.center,),
                  ),
                )
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 45,),
                  const SizedBox(width: 90, height: 90, child: Image(image: AssetImage('assets/star.png')),),
                  const SizedBox(height: 18),
                  Text('Введите номер телефона \n (10 цифр)',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: userController,
                          keyboardType: TextInputType.phone,
                          decoration: textFieldDecoration(Strings.fieldPhone, context),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.validName;
                            } else if (value.length !=10){
                              return Strings.validNameLength;
                            }
                            return null;
                          },
                        ),
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          decoration: textFieldDecoration(Strings.fieldPass, context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.validPass;
                            }
                            return null;
                          },
                        ),
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            _userStoredName = userController.text;
                            _userStoredPass = passController.text;
                            if (_checkAuthorization()) {
                              _saveUserData();
                            } else {
                              _userStoredName = '';
                              _userStoredPass = '';
                              _saveUserData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Ошибка доступа \n Неверные данные'), duration: Duration(seconds: 2)),
                              );
                            }
                          }
                          setState(() {});
                        },
                        child: const Text('Войти')
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Данные для входа:'),
                  const Text('Номер телефона: ${Strings.userName}'),
                  const Text('Пароль: ${Strings.userPass}'),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}