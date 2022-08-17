import 'dart:convert';
import 'dart:ffi';
import 'package:ca_app_flutter/src/home/radachart_view.dart';
import 'package:ca_app_flutter/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/data_type_request.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = LocalStorage('ca_app');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<User> _user;
  late final Future<DataTypeRequest> _dataTypeRequest = _getDataTypeRequest();

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      String userPref = prefs.getString('user') ?? "";
      Map<String, dynamic> userMap =
          jsonDecode(userPref) as Map<String, dynamic>;
      User user = User.fromJson(userMap);
    });
  }

  Future<String> _getAccessToken() {
    Future<String> accessTokenF = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('accessToken') ?? "";
    });
    return accessTokenF;
  }

  Future<DataTypeRequest> _getDataTypeRequest() async {
    String accessToken = await _getAccessToken();
    var url = Uri.http('180.93.175.236:3000', '/staff/ticketStatusAllByStaff');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': accessToken
    };
    var response = await http.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(response.body) as Map<String, dynamic>;
      var status = responseData['status'];
      print(status.map((val) => (val['statusName'].toString())).toList());
      print(status.map((val) => (val['quantity'] as int)).toList());
      return DataTypeRequest(
          List<String>.from(status
              .map((val) =>
                  val['statusName'].toString().replaceAll("_REQUEST", " "))
              .toList()),
          List<double>.from(
              status.map((val) => val['quantity'].toDouble()).toList()));
    } else {
      return DataTypeRequest([], []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 800,
            padding: EdgeInsets.zero,
            child: FutureBuilder<DataTypeRequest>(
                future: _dataTypeRequest,
                builder: (BuildContext context,
                    AsyncSnapshot<DataTypeRequest> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return RadarChartView(dataTypeRequest: snapshot.data!);
                        ;
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
