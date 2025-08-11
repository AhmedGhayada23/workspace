
class MainPageDataModel {
  Data? data;
  String? message;
  bool? status;

  MainPageDataModel({this.data, this.message, this.status});

  MainPageDataModel.fromJson(Map<String, dynamic> json) {
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

  static List<MainPageDataModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(MainPageDataModel.fromJson).toList();
  }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> mapData = <String, dynamic>{};
  if (data != null) {
    mapData["data"] = data!.toJson();
  }
  mapData["message"] = message;
  mapData["status"] = status;
  return mapData;
}
}

class Data {
  List<NewSpaces>? newSpaces;
  List<SuggestSpaces>? suggestSpaces;

  Data({this.newSpaces, this.suggestSpaces});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["new_spaces"] is List) {
      newSpaces = json["new_spaces"] == null ? null : (json["new_spaces"] as List).map((e) => NewSpaces.fromJson(e)).toList();
    }
    if(json["suggest_spaces"] is List) {
      suggestSpaces = json["suggest_spaces"] == null ? null : (json["suggest_spaces"] as List).map((e) => SuggestSpaces.fromJson(e)).toList();
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(newSpaces != null) {
      data["new_spaces"] = newSpaces?.map((e) => e.toJson()).toList();
    }
    if(suggestSpaces != null) {
      data["suggest_spaces"] = suggestSpaces?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class NewSpaces {
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
  String? videoUrl;
  int? videoId;
  List<String>? imagesUrl;
  int? ratingCount;
  dynamic ratingAverage;
  dynamic customerRatingCount;
  Company? company;
  List<dynamic>? evaluations;
  List<dynamic>? rooms;
  List<dynamic>? intervals;
  List<dynamic>? subscriptions;
  Province? province;

  NewSpaces({

    this.id,
      this.companyId,
      this.provinceId,
      this.content,
      this.availableFrom,
      this.availableTo,
      this.email,
      this.mobile,
      this.address,
      this.roomsCount,
      this.seatsCount,
      this.customersCount,
      this.createdAt,
      this.deletedAt,
      this.mainImageUrl,
      this.videoUrl,
      this.videoId,
      this.imagesUrl,
      this.ratingCount,
      this.ratingAverage,
      this.customerRatingCount,
      this.company,
      this.evaluations,
      this.rooms,
      this.intervals,
      this.subscriptions,
      this.province});

  NewSpaces.fromJson(Map<String, dynamic> json) {
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
    if(json["video_url"] is String) {
      videoUrl = json["video_url"];
    }
    if(json["video_id"] is int) {
      videoId = json["video_id"];
    }
    if(json["images_url"] is List) {
      imagesUrl = json["images_url"] == null ? null : List<String>.from(json["images_url"]);
    }
    if(json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }

    ratingAverage = json["rating_average"] ?? '';
    customerRatingCount = json["customer_rating_count"] ?? '';

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

  static List<NewSpaces> fromList(List<Map<String, dynamic>> list) {
    return list.map(NewSpaces.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["company_id"] = companyId;
    data["province_id"] = provinceId;
    data["content"] = content;
    data["available_from"] = availableFrom;
    data["available_to"] = availableTo;
    data["email"] = email;
    data["mobile"] = mobile;
    data["address"] = address;
    data["rooms_count"] = roomsCount;
    data["seats_count"] = seatsCount;
    data["customers_count"] = customersCount;
    data["created_at"] = createdAt;
    data["deleted_at"] = deletedAt;
    data["main_image_url"] = mainImageUrl;
    data["video_url"] = videoUrl;
    data["video_id"] = videoId;
    if(imagesUrl != null) {
      data["images_url"] = imagesUrl;
    }
    data["rating_count"] = ratingCount;
    data["rating_average"] = ratingAverage;
    data["customer_rating_count"] = customerRatingCount;
    if(company != null) {
      data["company"] = company?.toJson();
    }
    if(evaluations != null) {
      data["evaluations"] = evaluations;
    }
    if(rooms != null) {
      data["rooms"] = rooms;
    }
    if(intervals != null) {
      data["intervals"] = intervals;
    }
    if(subscriptions != null) {
      data["subscriptions"] = subscriptions;
    }
    if(province != null) {
      data["province"] = province?.toJson();
    }
    return data;
  }
}

class SuggestSpaces{
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
  String? videoUrl;
  int? videoId;
  List<String>? imagesUrl;
  int? ratingCount;
  dynamic ratingAverage;
  dynamic customerRatingCount;
  Company? company;
  List<dynamic>? evaluations;
  List<dynamic>? rooms;
  List<dynamic>? intervals;
  List<dynamic>? subscriptions;
  Province? province;

  SuggestSpaces(
      {this.id,
      this.companyId,
      this.provinceId,
      this.content,
      this.availableFrom,
      this.availableTo,
      this.email,
      this.mobile,
      this.address,
      this.roomsCount,
      this.seatsCount,
      this.customersCount,
      this.createdAt,
      this.deletedAt,
      this.mainImageUrl,
      this.videoUrl,
      this.videoId,
      this.imagesUrl,
      this.ratingCount,
      this.ratingAverage,
      this.customerRatingCount,
      this.company,
      this.evaluations,
      this.rooms,
      this.intervals,
      this.subscriptions,
      this.province});

  SuggestSpaces.fromJson(Map<String, dynamic> json) {
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
    if(json["video_url"] is String) {
      videoUrl = json["video_url"];
    }
    if(json["video_id"] is int) {
      videoId = json["video_id"];
    }
    if(json["images_url"] is List) {
      imagesUrl = json["images_url"] == null ? null : List<String>.from(json["images_url"]);
    }
    if(json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }

    ratingAverage = json["rating_average"] ?? '';
    customerRatingCount = json["customer_rating_count"] ?? '';

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

  static List<NewSpaces> fromList(List<Map<String, dynamic>> list) {
    return list.map(NewSpaces.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["company_id"] = companyId;
    data["province_id"] = provinceId;
    data["content"] = content;
    data["available_from"] = availableFrom;
    data["available_to"] = availableTo;
    data["email"] = email;
    data["mobile"] = mobile;
    data["address"] = address;
    data["rooms_count"] = roomsCount;
    data["seats_count"] = seatsCount;
    data["customers_count"] = customersCount;
    data["created_at"] = createdAt;
    data["deleted_at"] = deletedAt;
    data["main_image_url"] = mainImageUrl;
    data["video_url"] = videoUrl;
    data["video_id"] = videoId;
    if(imagesUrl != null) {
      data["images_url"] = imagesUrl;
    }
    data["rating_count"] = ratingCount;
    data["rating_average"] = ratingAverage;
    data["customer_rating_count"] = customerRatingCount;
    if(company != null) {
      data["company"] = company?.toJson();
    }
    if(evaluations != null) {
      data["evaluations"] = evaluations;
    }
    if(rooms != null) {
      data["rooms"] = rooms;
    }
    if(intervals != null) {
      data["intervals"] = intervals;
    }
    if(subscriptions != null) {
      data["subscriptions"] = subscriptions;
    }
    if(province != null) {
      data["province"] = province?.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["created_at"] = createdAt;
    data["deleted_at"] = deletedAt;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["name"] = name;
    data["type"] = type;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["type_title"] = typeTitle;
    data["image_url"] = imageUrl;
    if(media != null) {
      data["media"] = media;
    }
    return data;
  }
}
