class Status {
  String? statusName;
  double? quantity;

  Status({this.statusName, this.quantity});

  Status.fromJson(Map<String, dynamic> json) {
    statusName = json['statusName'];
    quantity = json['quantity'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusName'] = statusName;
    data['quantity'] = quantity;
    return data;
  }
}