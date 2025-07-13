
class NotificationModel {
  String? message;
  bool? status;
  Data? data;

  NotificationModel({this.message, this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  static List<NotificationModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(NotificationModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  List<Notifications>? notifications;
  int? notificationsCount;
  Pagination? pagination;

  Data({this.notifications, this.notificationsCount, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["notifications"] is List) {
      notifications = json["notifications"] == null ? null : (json["notifications"] as List).map((e) => Notifications.fromJson(e)).toList();
    }
    if(json["notifications_count"] is int) {
      notificationsCount = json["notifications_count"];
    }
    if(json["pagination"] is Map) {
      pagination = json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(notifications != null) {
      _data["notifications"] = notifications?.map((e) => e.toJson()).toList();
    }
    _data["notifications_count"] = notificationsCount;
    if(pagination != null) {
      _data["pagination"] = pagination?.toJson();
    }
    return _data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    if(json["current_page"] is int) {
      currentPage = json["current_page"];
    }
    if(json["last_page"] is int) {
      lastPage = json["last_page"];
    }
    if(json["per_page"] is int) {
      perPage = json["per_page"];
    }
    if(json["total"] is int) {
      total = json["total"];
    }
  }

  static List<Pagination> fromList(List<Map<String, dynamic>> list) {
    return list.map(Pagination.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["current_page"] = currentPage;
    _data["last_page"] = lastPage;
    _data["per_page"] = perPage;
    _data["total"] = total;
    return _data;
  }
}

class Notifications {
  int? id;
  String? type;
  Data1? data;
  String? title;
  String? body;
  dynamic readAt;
  int? createdBy;
  String? createdAt;
  CreatedByUser? createdByUser;

  Notifications({this.id, this.type, this.data, this.title, this.body, this.readAt, this.createdBy, this.createdAt, this.createdByUser});

  Notifications.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data1.fromJson(json["data"]);
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["body"] is String) {
      body = json["body"];
    }
    readAt = json["read_at"];
    if(json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["created_by_user"] is Map) {
      createdByUser = json["created_by_user"] == null ? null : CreatedByUser.fromJson(json["created_by_user"]);
    }
  }

  static List<Notifications> fromList(List<Map<String, dynamic>> list) {
    return list.map(Notifications.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["type"] = type;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["title"] = title;
    _data["body"] = body;
    _data["read_at"] = readAt;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    if(createdByUser != null) {
      _data["created_by_user"] = createdByUser?.toJson();
    }
    return _data;
  }
}

class CreatedByUser {
  int? id;
  String? name;
  Company? company;

  CreatedByUser({this.id, this.name, this.company});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["company"] is Map) {
      company = json["company"] == null ? null : Company.fromJson(json["company"]);
    }
  }

  static List<CreatedByUser> fromList(List<Map<String, dynamic>> list) {
    return list.map(CreatedByUser.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    if(company != null) {
      _data["company"] = company?.toJson();
    }
    return _data;
  }
}

class Company {
  int? id;
  String? name;
  String? imageUrl;
  String? typeTitle;

  Company({this.id, this.name, this.imageUrl, this.typeTitle});

  Company.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if(json["type_title"] is String) {
      typeTitle = json["type_title"];
    }
  }

  static List<Company> fromList(List<Map<String, dynamic>> list) {
    return list.map(Company.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["image_url"] = imageUrl;
    _data["type_title"] = typeTitle;
    return _data;
  }
}

class Data1 {
  int? reservationId;
  int? reservationStatus;
  String? reservationStatusTitle;
  String? companyName;

  Data1({this.reservationId, this.reservationStatus, this.reservationStatusTitle, this.companyName});

  Data1.fromJson(Map<String, dynamic> json) {
    if(json["reservation_id"] is int) {
      reservationId = json["reservation_id"];
    }
    if(json["reservation_status"] is int) {
      reservationStatus = json["reservation_status"];
    }
    if(json["reservation_status_title"] is String) {
      reservationStatusTitle = json["reservation_status_title"];
    }
    if(json["company_name"] is String) {
      companyName = json["company_name"];
    }
  }

  static List<Data1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["reservation_id"] = reservationId;
    _data["reservation_status"] = reservationStatus;
    _data["reservation_status_title"] = reservationStatusTitle;
    _data["company_name"] = companyName;
    return _data;
  }
}