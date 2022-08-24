import 'dart:convert';
import 'dart:convert' as convert;
import 'package:ca_app_flutter/src/home/home_view.dart';
import 'package:ca_app_flutter/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 1250);
  final LocalStorage storage = LocalStorage('ca_app');

  Future<String?> _authUser(LoginData data) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    var url = Uri.http('180.93.175.236:3000', '/staff/login');
    var body = jsonEncode({"username": data.name, "password": data.password});
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      User user = User.fromJson(
          convert.jsonDecode(response.body) as Map<String, dynamic>);
      await prefs.setString('user', jsonEncode(user.toJson()));
      await prefs.setString('accessToken', user.accessToken);
      storage.setItem("user", user);
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage("assets/fpt_logo.png"),
      userType: LoginUserType.name,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
        pageColorLight: const Color.fromRGBO(255, 255, 255, 1),
        pageColorDark: const Color.fromRGBO(44, 120, 229, 1),
        buttonTheme: const LoginButtonTheme(
            backgroundColor: Color.fromRGBO(44, 123, 229, 1)),
        cardTheme: const CardTheme(
          margin: EdgeInsets.only(top: 100),
        ),
        cardInitialHeight: 200,
      ),
      userValidator: (value) { return null;},
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
