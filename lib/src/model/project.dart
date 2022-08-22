class Project {
  int? id;
  String? name;
  String? projectCategory;
  String? projectCode;
  String? image;

  Project(
      {this.id, this.name, this.projectCategory, this.projectCode, this.image});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    projectCategory = json['project_category'];
    projectCode = json['project_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['project_category'] = projectCategory;
    data['project_code'] = projectCode;
    data['image'] = image;
    return data;
  }
}
