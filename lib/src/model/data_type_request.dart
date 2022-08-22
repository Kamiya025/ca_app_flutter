import 'package:ca_app_flutter/src/model/status.dart';

class DataTypeRequest {
  List<String> titles;
  List<double> dataSet;

  DataTypeRequest(this.titles, this.dataSet);

  DataTypeRequest.fromRequests(List<Status> status):
    titles = List<String>.from(status
        .map((val) => val.statusName.toString().replaceAll("_REQUEST", " "))
        .toList()),
    dataSet = List<double>.from(
    status.map((val) => val.quantity).toList());
}


