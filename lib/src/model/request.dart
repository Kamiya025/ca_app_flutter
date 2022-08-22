class RequestData
{
  String requestName;
  double quantity;

  RequestData(this.requestName, this.quantity);

  RequestData.fromJson(Map<String, dynamic> json)
      : requestName = json['requestName'],
        quantity = json['quantity'].toDouble();

}
class Requests {
  String? requestName;
  double? quantity;

  Requests({this.requestName, this.quantity});

  Requests.fromJson(Map<String, dynamic> json) {
    requestName = json['requestName'];
    quantity = json['quantity'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestName'] = requestName;
    data['quantity'] = quantity;
    return data;
  }
}
