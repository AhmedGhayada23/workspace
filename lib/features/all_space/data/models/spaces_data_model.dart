
class SpacesDataModel {
  Data? data;
  String? message;
  bool? status;

  SpacesDataModel({this.data, this.message, this.status});

  SpacesDataModel.fromJson(Map<String, dynamic> json) {
    if(json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<SpacesDataModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(SpacesDataModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["message"] = message;
    _data["status"] = status;
    return _data;
  }
}

class Data {
  List<Spaces>? spaces;
  Pagination? pagination;

  Data({this.spaces, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["spaces"] is List) {
      spaces = json["spaces"] == null ? null : (json["spaces"] as List).map((e) => Spaces.fromJson(e)).toList();
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
    if(spaces != null) {
      _data["spaces"] = spaces?.map((e) => e.toJson()).toList();
    }
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

class Spaces {
  int? id;
  int? companyId;
  int? provinceId;
  String? content;
  String? availableFrom;
  String? availableTo;
  String? email;
  String? mobile;
  String? address;
  int? roomsCount;
  int? seatsCount;
  int? customersCount;
  String? createdAt;
  dynamic deletedAt;
  String? mainImageUrl;
  dynamic videoUrl;
  dynamic videoId;
  List<dynamic>? imagesUrl;
  int? ratingCount;
  int? ratingAverage;
  Company? company;
  List<dynamic>? evaluations;
  List<dynamic>? rooms;
  List<dynamic>? intervals;
  List<dynamic>? subscriptions;
  Province? province;

  Spaces({this.id, this.companyId, this.provinceId, this.content, this.availableFrom, this.availableTo, this.email, this.mobile, this.address, this.roomsCount, this.seatsCount, this.customersCount, this.createdAt, this.deletedAt, this.mainImageUrl, this.videoUrl, this.videoId, this.imagesUrl, this.ratingCount, this.ratingAverage, this.company, this.evaluations, this.rooms, this.intervals, this.subscriptions, this.province});

  Spaces.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["company_id"] is int) {
      companyId = json["company_id"];
    }
    if(json["province_id"] is int) {
      provinceId = json["province_id"];
    }
    if(json["content"] is String) {
      content = json["content"];
    }
    if(json["available_from"] is String) {
      availableFrom = json["available_from"];
    }
    if(json["available_to"] is String) {
      availableTo = json["available_to"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["rooms_count"] is int) {
      roomsCount = json["rooms_count"];
    }
    if(json["seats_count"] is int) {
      seatsCount = json["seats_count"];
    }
    if(json["customers_count"] is int) {
      customersCount = json["customers_count"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    deletedAt = json["deleted_at"];
    if(json["main_image_url"] is String) {
      mainImageUrl = json["main_image_url"];
    }
    videoUrl = json["video_url"];
    videoId = json["video_id"];
    if(json["images_url"] is List) {
      imagesUrl = json["images_url"] ?? [];
    }
    if(json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }
    if(json["rating_average"] is int) {
      ratingAverage = json["rating_average"];
    }
    if(json["company"] is Map) {
      company = json["company"] == null ? null : Company.fromJson(json["company"]);
    }
    if(json["evaluations"] is List) {
      evaluations = json["evaluations"] ?? [];
    }
    if(json["rooms"] is List) {
      rooms = json["rooms"] ?? [];
    }
    if(json["intervals"] is List) {
      intervals = json["intervals"] ?? [];
    }
    if(json["subscriptions"] is List) {
      subscriptions = json["subscriptions"] ?? [];
    }
    if(json["province"] is Map) {
      province = json["province"] == null ? null : Province.fromJson(json["province"]);
    }
  }

  static List<Spaces> fromList(List<Map<String, dynamic>> list) {
    return list.map(Spaces.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["company_id"] = companyId;
    _data["province_id"] = provinceId;
    _data["content"] = content;
    _data["available_from"] = availableFrom;
    _data["available_to"] = availableTo;
    _data["email"] = email;
    _data["mobile"] = mobile;
    _data["address"] = address;
    _data["rooms_count"] = roomsCount;
    _data["seats_count"] = seatsCount;
    _data["customers_count"] = customersCount;
    _data["created_at"] = createdAt;
    _data["deleted_at"] = deletedAt;
    _data["main_image_url"] = mainImageUrl;
    _data["video_url"] = videoUrl;
    _data["video_id"] = videoId;
    if(imagesUrl != null) {
      _data["images_url"] = imagesUrl;
    }
    _data["rating_count"] = ratingCount;
    _data["rating_average"] = ratingAverage;
    if(company != null) {
      _data["company"] = company?.toJson();
    }
    if(evaluations != null) {
      _data["evaluations"] = evaluations;
    }
    if(rooms != null) {
      _data["rooms"] = rooms;
    }
    if(intervals != null) {
      _data["intervals"] = intervals;
    }
    if(subscriptions != null) {
      _data["subscriptions"] = subscriptions;
    }
    if(province != null) {
      _data["province"] = province?.toJson();
    }
    return _data;
  }
}

class Province {
  int? id;
  String? name;
  String? createdAt;
  dynamic deletedAt;

  Province({this.id, this.name, this.createdAt, this.deletedAt});

  Province.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    deletedAt = json["deleted_at"];
  }

  static List<Province> fromList(List<Map<String, dynamic>> list) {
    return list.map(Province.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["created_at"] = createdAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}

class Company {
  int? id;
  int? userId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;
  String? imageUrl;
  List<dynamic>? media;

  Company({this.id, this.userId, this.name, this.type, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle, this.imageUrl, this.media});

  Company.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    if(json["type_title"] is String) {
      typeTitle = json["type_title"];
    }
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if(json["media"] is List) {
      media = json["media"] ?? [];
    }
  }

  static List<Company> fromList(List<Map<String, dynamic>> list) {
    return list.map(Company.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["name"] = name;
    _data["type"] = type;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["type_title"] = typeTitle;
    _data["image_url"] = imageUrl;
    if(media != null) {
      _data["media"] = media;
    }
    return _data;
  }
}