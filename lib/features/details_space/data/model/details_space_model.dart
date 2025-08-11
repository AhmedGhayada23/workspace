
class DetailsSpaceModel {
  Data? data;
  String? message;
  bool? status;

  DetailsSpaceModel({this.data, this.message, this.status});

  DetailsSpaceModel.fromJson(Map<String, dynamic> json) {
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

  static List<DetailsSpaceModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DetailsSpaceModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["data"] = data?.toJson(); // هنا `data` هو متغير من الكلاس وليس الـ map
    map["message"] = message;
    map["status"] = status;
    return map;
  }
}

class Data {
  Spaces? spaces;
  List<SuggestSpaces>? suggestSpaces;

  Data({this.spaces, this.suggestSpaces});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["spaces"] is Map) {
      spaces = json["spaces"] == null ? null : Spaces.fromJson(json["spaces"]);
    }
    if (json["suggest_spaces"] is List) {
      suggestSpaces = json["suggest_spaces"] == null ? null : (json["suggest_spaces"] as List).map((e) => SuggestSpaces.fromJson(e)).toList();
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(spaces != null) {
      data["spaces"] = spaces?.toJson();
    }
    if (suggestSpaces != null) {
      data["suggest_spaces"] = suggestSpaces?.map((e) => e.toJson()).toList();
    }
    return data;
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
  List<String>? imagesUrl;
  List<int>? imagesId;
  int? ratingCount;
  double? ratingAverage;
  List<CustomerRatingAverages>? customerRatingAverages;
  Company? company;
  List<Evaluations>? evaluations;
  List<Rooms>? rooms;
  List<dynamic>? intervals;
  List<Subscriptions>? subscriptions;
  Province? province;

  Spaces(
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
      this.imagesId,
      this.ratingCount,
      this.ratingAverage,
      this.customerRatingAverages,
      this.company,
      this.evaluations,
      this.rooms,
      this.intervals,
      this.subscriptions,
      this.province});

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
      imagesUrl = json["images_url"] == null ? null : List<String>.from(json["images_url"]);
    }
    if(json["images_id"] is List) {
      imagesId = json["images_id"] == null ? null : List<int>.from(json["images_id"]);
    }
    if (json["customer_rating_count"] is int) {
      ratingCount = json["customer_rating_count"];
    }
    if(json["rating_average"] is double) {
      ratingAverage = json["rating_average"];
    }
    if (json["customer_rating_averages"] is List) {
      customerRatingAverages = json["customer_rating_averages"] == null
          ? null
          : (json["customer_rating_averages"] as List)
              .map((e) => CustomerRatingAverages.fromJson(e))
              .toList();
    }
    if(json["company"] is Map) {
      company = json["company"] == null ? null : Company.fromJson(json["company"]);
    }
    if(json["evaluations"] is List) {
      evaluations = json["evaluations"] == null ? null : (json["evaluations"] as List).map((e) => Evaluations.fromJson(e)).toList();
    }
    if(json["rooms"] is List) {
      rooms = json["rooms"] == null ? null : (json["rooms"] as List).map((e) => Rooms.fromJson(e)).toList();
    }
    if(json["intervals"] is List) {
      intervals = json["intervals"] ?? [];
    }
    if(json["subscriptions"] is List) {
      subscriptions = json["subscriptions"] == null ? null : (json["subscriptions"] as List).map((e) => Subscriptions.fromJson(e)).toList();
    }
    if(json["province"] is Map) {
      province = json["province"] == null ? null : Province.fromJson(json["province"]);
    }
  }

  static List<Spaces> fromList(List<Map<String, dynamic>> list) {
    return list.map(Spaces.fromJson).toList();
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
    if(imagesId != null) {
      data["images_id"] = imagesId;
    }
    data["customer_rating_count"] = ratingCount;
    data["rating_average"] = ratingAverage;
    if (customerRatingAverages != null) {
      data["customer_rating_averages"] = customerRatingAverages?.map((e) => e.toJson()).toList();
    }
    if(company != null) {
      data["company"] = company?.toJson();
    }
    if(evaluations != null) {
      data["evaluations"] = evaluations?.map((e) => e.toJson()).toList();
    }
    if(rooms != null) {
      data["rooms"] = rooms?.map((e) => e.toJson()).toList();
    }
    if(intervals != null) {
      data["intervals"] = intervals;
    }
    if(subscriptions != null) {
      data["subscriptions"] = subscriptions?.map((e) => e.toJson()).toList();
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

class Subscriptions {
  int? id;
  int? spaceId;
  String? type;
  String? price;
  int? customersCount;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;

  Subscriptions({this.id, this.spaceId, this.type, this.price, this.customersCount, this.createdBy, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["space_id"] is int) {
      spaceId = json["space_id"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["customers_count"] is int) {
      customersCount = json["customers_count"];
    }
    if(json["created_by"] is int) {
      createdBy = json["created_by"];
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
  }

  static List<Subscriptions> fromList(List<Map<String, dynamic>> list) {
    return list.map(Subscriptions.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["space_id"] = spaceId;
    data["type"] = type;
    data["price"] = price;
    data["customers_count"] = customersCount;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["type_title"] = typeTitle;
    return data;
  }
}

class Rooms {
  int? id;
  int? spaceId;
  String? name;
  int? seatsCount;
  int? customersCount;
  String? createdAt;
  dynamic deletedAt;

  Rooms({this.id, this.spaceId, this.name, this.seatsCount, this.customersCount, this.createdAt, this.deletedAt});

  Rooms.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["space_id"] is int) {
      spaceId = json["space_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
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
  }

  static List<Rooms> fromList(List<Map<String, dynamic>> list) {
    return list.map(Rooms.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["space_id"] = spaceId;
    data["name"] = name;
    data["seats_count"] = seatsCount;
    data["customers_count"] = customersCount;
    data["created_at"] = createdAt;
    data["deleted_at"] = deletedAt;
    return data;
  }
}

class Evaluations {
  int? id;
  int? customerId;
  int? spaceId;
  String? value;
  String? message;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;
  Customer? customer;

  Evaluations({this.id, this.customerId, this.spaceId, this.value, this.message, this.type, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle, this.customer});

  Evaluations.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["customer_id"] is int) {
      customerId = json["customer_id"];
    }
    if(json["space_id"] is int) {
      spaceId = json["space_id"];
    }
    if(json["value"] is String) {
      value = json["value"];
    }
    if(json["message"] is String) {
      message = json["message"];
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
    if(json["customer"] is Map) {
      customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
  }

  static List<Evaluations> fromList(List<Map<String, dynamic>> list) {
    return list.map(Evaluations.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["customer_id"] = customerId;
    data["space_id"] = spaceId;
    data["value"] = value;
    data["message"] = message;
    data["type"] = type;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["type_title"] = typeTitle;
    if(customer != null) {
      data["customer"] = customer?.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  int? userId;
  dynamic aboutMe;
  dynamic address;
  String? type;
  dynamic gender;
  dynamic age;
  dynamic dob;
  dynamic university;
  dynamic specialty;
  dynamic universityNumber;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;
  dynamic genderTitle;
  String? imageUrl;
  List<dynamic>? documentsUrl;
  List<dynamic>? documentsId;
  User1? user;
  List<dynamic>? media;

  Customer({this.id, this.userId, this.aboutMe, this.address, this.type, this.gender, this.age, this.dob, this.university, this.specialty, this.universityNumber, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle, this.genderTitle, this.imageUrl, this.documentsUrl, this.documentsId, this.user, this.media});

  Customer.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["user_id"] is int) {
      userId = json["user_id"];
    }
    aboutMe = json["about_me"];
    address = json["address"];
    if(json["type"] is String) {
      type = json["type"];
    }
    gender = json["gender"];
    age = json["age"];
    dob = json["dob"];
    university = json["university"];
    specialty = json["specialty"];
    universityNumber = json["university_number"];
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
    genderTitle = json["gender_title"];
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if(json["documents_url"] is List) {
      documentsUrl = json["documents_url"] ?? [];
    }
    if(json["documents_id"] is List) {
      documentsId = json["documents_id"] ?? [];
    }
    if(json["user"] is Map) {
      user = json["user"] == null ? null : User1.fromJson(json["user"]);
    }
    if(json["media"] is List) {
      media = json["media"] ?? [];
    }
  }

  static List<Customer> fromList(List<Map<String, dynamic>> list) {
    return list.map(Customer.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["about_me"] = aboutMe;
    data["address"] = address;
    data["type"] = type;
    data["gender"] = gender;
    data["age"] = age;
    data["dob"] = dob;
    data["university"] = university;
    data["specialty"] = specialty;
    data["university_number"] = universityNumber;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["type_title"] = typeTitle;
    data["gender_title"] = genderTitle;
    data["image_url"] = imageUrl;
    if(documentsUrl != null) {
      data["documents_url"] = documentsUrl;
    }
    if(documentsId != null) {
      data["documents_id"] = documentsId;
    }
    if(user != null) {
      data["user"] = user?.toJson();
    }
    if(media != null) {
      data["media"] = media;
    }
    return data;
  }
}

class User1 {
  int? id;
  String? name;
  String? email;
  String? type;
  dynamic refreshToken;
  String? mobile;
  String? emailVerifiedAt;
  String? fcmToken;
  dynamic deactivatedBy;
  dynamic deactivatedAt;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic lastLoginAt;
  String? personalImageUrl;
  String? activeTitle;
  int? active;

  User1(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.refreshToken,
      this.mobile,
      this.emailVerifiedAt,
      this.fcmToken,
      this.deactivatedBy,
      this.deactivatedAt,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.lastLoginAt,
      this.personalImageUrl,
      this.activeTitle,
      this.active});

  User1.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    refreshToken = json["refresh_token"];
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["email_verified_at"] is String) {
      emailVerifiedAt = json["email_verified_at"];
    }
    if (json["fcm_token"] is String) {
      fcmToken = json["fcm_token"];
    }
    deactivatedBy = json["deactivated_by"];
    deactivatedAt = json["deactivated_at"];
    if (json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    lastLoginAt = json["last_login_at"];
    if (json["personal_image_url"] is String) {
      personalImageUrl = json["personal_image_url"];
    }
    if (json["active_title"] is String) {
      activeTitle = json["active_title"];
    }
    if (json["active"] is int) {
      active = json["active"];
    }
  }

  static List<User1> fromList(List<Map<String, dynamic>> list) {
    return list.map(User1.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["type"] = type;
    data["refresh_token"] = refreshToken;
    data["mobile"] = mobile;
    data["email_verified_at"] = emailVerifiedAt;
    data["fcm_token"] = fcmToken;
    data["deactivated_by"] = deactivatedBy;
    data["deactivated_at"] = deactivatedAt;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["last_login_at"] = lastLoginAt;
    data["personal_image_url"] = personalImageUrl;
    data["active_title"] = activeTitle;
    data["active"] = active;
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
  User? user;

  Company(
      {this.id,
      this.userId,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.typeTitle,
      this.imageUrl,
      this.user});

  Company.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["user_id"] is int) {
      userId = json["user_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    if (json["type_title"] is String) {
      typeTitle = json["type_title"];
    }
    if (json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if (json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
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
    if (user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? type;
  dynamic refreshToken;
  String? mobile;
  String? emailVerifiedAt;
  dynamic fcmToken;
  dynamic deactivatedBy;
  dynamic deactivatedAt;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic lastLoginAt;
  String? personalImageUrl;
  String? activeTitle;
  int? active;

  User(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.refreshToken,
      this.mobile,
      this.emailVerifiedAt,
      this.fcmToken,
      this.deactivatedBy,
      this.deactivatedAt,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.lastLoginAt,
      this.personalImageUrl,
      this.activeTitle,
      this.active});

  User.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    refreshToken = json["refresh_token"];
    if(json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if(json["email_verified_at"] is String) {
      emailVerifiedAt = json["email_verified_at"];
    }
    fcmToken = json["fcm_token"];
    deactivatedBy = json["deactivated_by"];
    deactivatedAt = json["deactivated_at"];
    if(json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    lastLoginAt = json["last_login_at"];
    if(json["personal_image_url"] is String) {
      personalImageUrl = json["personal_image_url"];
    }
    if(json["active_title"] is String) {
      activeTitle = json["active_title"];
    }
    if(json["active"] is int) {
      active = json["active"];
    }
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["type"] = type;
    data["refresh_token"] = refreshToken;
    data["mobile"] = mobile;
    data["email_verified_at"] = emailVerifiedAt;
    data["fcm_token"] = fcmToken;
    data["deactivated_by"] = deactivatedBy;
    data["deactivated_at"] = deactivatedAt;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["last_login_at"] = lastLoginAt;
    data["personal_image_url"] = personalImageUrl;
    data["active_title"] = activeTitle;
    data["active"] = active;
    return data;
  }
}

class CustomerRatingAverages {
  int? customerId;
  String? name;
  String? imageUrl;
  String? email;
  String? mobile;
  double? average;
  String? message;
  String? createdAt;

  CustomerRatingAverages(
      {this.customerId,
      this.name,
      this.imageUrl,
      this.email,
      this.mobile,
      this.average,
      this.message,
      this.createdAt});

  CustomerRatingAverages.fromJson(Map<String, dynamic> json) {
    if (json["customer_id"] is int) {
      customerId = json["customer_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["average"] is double) {
      average = json["average"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  static List<CustomerRatingAverages> fromList(List<Map<String, dynamic>> list) {
    return list.map(CustomerRatingAverages.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer_id"] = customerId;
    data["name"] = name;
    data["image_url"] = imageUrl;
    data["email"] = email;
    data["mobile"] = mobile;
    data["average"] = average;
    data["message"] = message;
    data["created_at"] = createdAt;
    return data;
  }
}

// class  {
//   Data? data;
//   String? message;
//   bool? status;

//   DetailsSpaceModel({this.data, this.message, this.status});

//   DetailsSpaceModel.fromJson(Map<String, dynamic> json) {
//     if(json["data"] is Map) {
//       data = json["data"] == null ? null : Data.fromJson(json["data"]);
//     }
//     if(json["message"] is String) {
//       message = json["message"];
//     }
//     if(json["status"] is bool) {
//       status = json["status"];
//     }
//   }

//   static List<DetailsSpaceModel> fromList(List<Map<String, dynamic>> list) {
//     return list.map(DetailsSpaceModel.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//       data["message"] = message;
//     data["status"] = status;
//     return data;
//   }
// }

// class Data {
//   Spaces? spaces;
//   List<SuggestSpaces>? suggestSpaces;

//   Data({this.spaces, this.suggestSpaces});

//   Data.fromJson(Map<String, dynamic> json) {
//     if(json["spaces"] is Map) {
//       spaces = json["spaces"] == null ? null : Spaces.fromJson(json["spaces"]);
//     }
//     if(json["suggest_spaces"] is List) {
//       suggestSpaces = json["suggest_spaces"] == null ? null : (json["suggest_spaces"] as List).map((e) => SuggestSpaces.fromJson(e)).toList();
//     }
//   }

//   static List<Data> fromList(List<Map<String, dynamic>> list) {
//     return list.map(Data.fromJson).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if(spaces != null) {
//       data["spaces"] = spaces?.toJson();
//     }
//     if(suggestSpaces != null) {
//       data["suggest_spaces"] = suggestSpaces?.map((e) => e.toJson()).toList();
//     }
//     return data;
//   }
// }

class SuggestSpaces {
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
  List<dynamic>? imagesId;
  int? ratingCount;
  int? ratingAverage;
  Company1? company;
  List<dynamic>? evaluations;
  List<dynamic>? rooms;
  List<dynamic>? intervals;
  List<dynamic>? subscriptions;
  Province1? province;

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
      this.imagesId,
      this.ratingCount,
      this.ratingAverage,
      this.company,
      this.evaluations,
      this.rooms,
      this.intervals,
      this.subscriptions,
      this.province});

  SuggestSpaces.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["company_id"] is int) {
      companyId = json["company_id"];
    }
    if (json["province_id"] is int) {
      provinceId = json["province_id"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
    if (json["available_from"] is String) {
      availableFrom = json["available_from"];
    }
    if (json["available_to"] is String) {
      availableTo = json["available_to"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["address"] is String) {
      address = json["address"];
    }
    if (json["rooms_count"] is int) {
      roomsCount = json["rooms_count"];
    }
    if (json["seats_count"] is int) {
      seatsCount = json["seats_count"];
    }
    if (json["customers_count"] is int) {
      customersCount = json["customers_count"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    deletedAt = json["deleted_at"];
    if (json["main_image_url"] is String) {
      mainImageUrl = json["main_image_url"];
    }
    videoUrl = json["video_url"];
    videoId = json["video_id"];
    if (json["images_url"] is List) {
      imagesUrl = json["images_url"] ?? [];
    }
    if (json["images_id"] is List) {
      imagesId = json["images_id"] ?? [];
    }
    if (json["customer_rating_count"] is int) {
      ratingCount = json["customer_rating_count"];
    }
    if (json["rating_average"] is int) {
      ratingAverage = json["rating_average"];
    }
    if (json["company"] is Map) {
      company = json["company"] == null ? null : Company1.fromJson(json["company"]);
    }
    if (json["evaluations"] is List) {
      evaluations = json["evaluations"] ?? [];
    }
    if (json["rooms"] is List) {
      rooms = json["rooms"] ?? [];
    }
    if (json["intervals"] is List) {
      intervals = json["intervals"] ?? [];
    }
    if (json["subscriptions"] is List) {
      subscriptions = json["subscriptions"] ?? [];
    }
    if (json["province"] is Map) {
      province = json["province"] == null ? null : Province1.fromJson(json["province"]);
    }
  }

  static List<SuggestSpaces> fromList(List<Map<String, dynamic>> list) {
    return list.map(SuggestSpaces.fromJson).toList();
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
    if (imagesUrl != null) {
      data["images_url"] = imagesUrl;
    }
    if (imagesId != null) {
      data["images_id"] = imagesId;
    }
    data["customer_rating_count"] = ratingCount;
    data["rating_average"] = ratingAverage;
    if (company != null) {
      data["company"] = company?.toJson();
    }
    if (evaluations != null) {
      data["evaluations"] = evaluations;
    }
    if (rooms != null) {
      data["rooms"] = rooms;
    }
    if (intervals != null) {
      data["intervals"] = intervals;
    }
    if (subscriptions != null) {
      data["subscriptions"] = subscriptions;
    }
    if (province != null) {
      data["province"] = province?.toJson();
    }
    return data;
  }
}

class Province1 {
  int? id;
  String? name;
  String? createdAt;
  dynamic deletedAt;

  Province1({this.id, this.name, this.createdAt, this.deletedAt});

  Province1.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    deletedAt = json["deleted_at"];
  }

  static List<Province1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Province1.fromJson).toList();
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

class Company1 {
  int? id;
  int? userId;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;
  String? imageUrl;
  User2? user;

  Company1(
      {this.id,
      this.userId,
      this.name,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.typeTitle,
      this.imageUrl,
      this.user});

  Company1.fromJson(Map<String, dynamic> json) {
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
    if(json["user"] is Map) {
      user = json["user"] == null ? null : User2.fromJson(json["user"]);
    }
  }

  static List<Company1> fromList(List<Map<String, dynamic>> list) {
    return list.map(Company1.fromJson).toList();
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
    if(user != null) {
      data["user"] = user?.toJson();
    }
    return data;
  }
}

class User2 {
  int? id;
  String? name;
  String? email;
  String? type;
  dynamic refreshToken;
  String? mobile;
  dynamic emailVerifiedAt;
  dynamic fcmToken;
  dynamic deactivatedBy;
  dynamic deactivatedAt;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic lastLoginAt;
  String? personalImageUrl;
  String? activeTitle;
  int? active;

  User2(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.refreshToken,
      this.mobile,
      this.emailVerifiedAt,
      this.fcmToken,
      this.deactivatedBy,
      this.deactivatedAt,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.lastLoginAt,
      this.personalImageUrl,
      this.activeTitle,
      this.active});

  User2.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    refreshToken = json["refresh_token"];
    if(json["mobile"] is String) {
      mobile = json["mobile"];
    }
    emailVerifiedAt = json["email_verified_at"];
    fcmToken = json["fcm_token"];
    deactivatedBy = json["deactivated_by"];
    deactivatedAt = json["deactivated_at"];
    if(json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];
    lastLoginAt = json["last_login_at"];
    if(json["personal_image_url"] is String) {
      personalImageUrl = json["personal_image_url"];
    }
    if(json["active_title"] is String) {
      activeTitle = json["active_title"];
    }
    if(json["active"] is int) {
      active = json["active"];
    }
  }

  static List<User2> fromList(List<Map<String, dynamic>> list) {
    return list.map(User2.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["type"] = type;
    data["refresh_token"] = refreshToken;
    data["mobile"] = mobile;
    data["email_verified_at"] = emailVerifiedAt;
    data["fcm_token"] = fcmToken;
    data["deactivated_by"] = deactivatedBy;
    data["deactivated_at"] = deactivatedAt;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["last_login_at"] = lastLoginAt;
    data["personal_image_url"] = personalImageUrl;
    data["active_title"] = activeTitle;
    data["active"] = active;
    return data;
  }
}

