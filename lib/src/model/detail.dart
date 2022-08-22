class Details {
  int? id;
  String? customerName;
  int? projectId;
  Null? categoryId;
  String? email;
  String? phone;
  String? dateCreate;
  String? resolvedDate;
  String? summary;
  Null? descriptionByCustomer;
  int? groupId;
  int? priorityId;
  // Scope? scope;
  String? assigneeId;
  String? descriptionByStaff;
  String? statusName;
  int? statusId;
  int? requestTypeId;
  String? requestTypeName;
  String? issueId;
  String? issueKey;

  Details(
      {this.id,
        this.customerName,
        this.projectId,
        this.categoryId,
        this.email,
        this.phone,
        this.dateCreate,
        this.resolvedDate,
        this.summary,
        this.descriptionByCustomer,
        this.groupId,
        this.priorityId,
        // this.scope,
        this.assigneeId,
        this.descriptionByStaff,
        this.statusName,
        this.statusId,
        this.requestTypeId,
        this.requestTypeName,
        this.issueId,
        this.issueKey});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    projectId = json['project_id'];
    categoryId = json['category_id'];
    email = json['email'];
    phone = json['phone'];
    dateCreate = json['date_create'];
    resolvedDate = json['resolved_date'];
    summary = json['summary'];
    descriptionByCustomer = json['description_by_customer'];
    groupId = json['group_id'];
    priorityId = json['priority_id'];
    // scope = json['scope'] != null ? new Scope.fromJson(json['scope']) : null;
    assigneeId = json['assignee_id'];
    descriptionByStaff = json['description_by_staff'];
    statusName = json['status_name'];
    statusId = json['status_id'];
    requestTypeId = json['request_type_id'];
    requestTypeName = json['request_type_name'];
    issueId = json['issue_id'];
    issueKey = json['issue_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['project_id'] = projectId;
    data['category_id'] = categoryId;
    data['email'] = email;
    data['phone'] = phone;
    data['date_create'] = dateCreate;
    data['resolved_date'] = resolvedDate;
    data['summary'] = summary;
    data['description_by_customer'] = descriptionByCustomer;
    data['group_id'] = groupId;
    data['priority_id'] = priorityId;
    // if (scope != null) {
    //   data['scope'] = scope!.toJson();
    // }
    data['assignee_id'] = assigneeId;
    data['description_by_staff'] = descriptionByStaff;
    data['status_name'] = statusName;
    data['status_id'] = statusId;
    data['request_type_id'] = requestTypeId;
    data['request_type_name'] = requestTypeName;
    data['issue_id'] = issueId;
    data['issue_key'] = issueKey;
    return data;
  }
}