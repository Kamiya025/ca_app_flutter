import 'detail.dart';

class Tickets {
  String? type;
  List<Details>? details;

  Tickets({this.type, this.details});

  Tickets.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
