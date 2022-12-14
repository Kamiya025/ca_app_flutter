import 'dart:async';
import 'dart:convert';
import 'package:ca_app_flutter/src/model/all_tickets_status.dart';
import 'package:ca_app_flutter/src/model/project.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel {
  AllTicketsStatus allTicketsStatus = AllTicketsStatus();
  List<double> dataTimespent = [0];
  List<Project> projects = [];
  StreamController allTicketsStatusController = StreamController<AllTicketsStatus>();
  StreamController dataTimespentController = StreamController<List<double>>();
  StreamController projectsController = StreamController<List<Project>>();

  Stream<AllTicketsStatus> get allTicketsStatusStream =>
      Stream<AllTicketsStatus>.fromFuture(getAllTicketsStatus());

  Stream<List<double>> get dataTimespentStream =>
      Stream<List<double>>.fromFuture(getTimeSpent());

  Stream<List<Project>> get projectsStream =>
      Stream<List<Project>>.fromFuture(getProjects());

  Future<List<double>> getTimeSpent() async {
    var response = await _getTimespent();

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(response.body) as Map<String, dynamic>;
      var details = responseData['details'];
      List<double> timeSpent =
          List<double>.from(details.map((val) => val.toDouble()).toList());
      return timeSpent;
    } else {
      return [0];
    }
  }

  Future<http.Response> _getTicketStatusAllByStaff() async {
    String accessToken = await _getAccessToken();
    var url = Uri.http('180.93.175.236:3000', '/staff/ticketStatusAllByStaff');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': accessToken
    };
    return http.get(
      url,
      headers: requestHeaders,
    );
  }

  Future<http.Response> _getTimespent() async {
    String accessToken = await _getAccessToken();
    var url = Uri.http('180.93.175.236:3000', '/staff/getTimeSpent');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': accessToken
    };
    return http.get(
      url,
      headers: requestHeaders,
    );
  }

  Future<String> _getAccessToken() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    Future<String> accessTokenF = prefs.then((SharedPreferences prefs) {
      return prefs.getString('accessToken') ?? "";
    });
    return accessTokenF;
  }

  Future<AllTicketsStatus> getAllTicketsStatus() async {
    var response = await _getTicketStatusAllByStaff();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          jsonDecode(response.body) as Map<String, dynamic>;
      return AllTicketsStatus.fromJson(responseData);
    } else {
      return AllTicketsStatus();
    }
  }

  Future<List<Project>> getProjects() async {
    String accessToken = await _getAccessToken();
    var url = Uri.http('180.93.175.236:3000', '/staff/getAllProjects');
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
      var details = responseData['details'];
      var pjs =  List<Project>.from(details.map((val) => Project.fromJson(val)).toList());
      return pjs;

    } else {
      return [];
    }
  }
  void dispose() {
    dataTimespentController.close();
    allTicketsStatusController.close();
    projectsController.close();
  }


}

