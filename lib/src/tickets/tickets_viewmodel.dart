import 'dart:async';
import 'dart:convert';
import 'package:ca_app_flutter/src/model/all_tickets_status.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TicketsViewModel {
  AllTicketsStatus allTicketsStatus = AllTicketsStatus();

  StreamController allTicketsStatusController = StreamController<AllTicketsStatus>();
  Stream<AllTicketsStatus> get allTicketsStatusStream =>
      Stream<AllTicketsStatus>.fromFuture(getAllTicketsStatus());


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
  void dispose() {
    allTicketsStatusController.close();
  }


}

