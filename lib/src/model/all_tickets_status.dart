import 'package:ca_app_flutter/src/model/request.dart';
import 'package:ca_app_flutter/src/model/status.dart';
import 'package:ca_app_flutter/src/model/ticket.dart';

class AllTicketsStatus {
  List<Tickets>? tickets;
  List<Status>? status;
  List<Requests>? requests;

  AllTicketsStatus({this.tickets, this.status, this.requests});

  AllTicketsStatus.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    if (json['status'] != null) {
      status = <Status>[];
      json['status'].forEach((v) {
        status!.add(Status.fromJson(v));
      });
    }
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status!.map((v) => v.toJson()).toList();
    }
    if (requests != null) {
      data['requests'] = requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




// class Scope {
//   String? type;
//   List<int>? data;
//
//   Scope({this.type, this.data});
//
//   Scope.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     data = json['data'].cast<int>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = type;
//     data['data'] = data;
//     return data;
//   }
// }


