
class ProfileDataModel {
  Data? data;
  String? message;
  bool? status;

  ProfileDataModel({this.data, this.message, this.status});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
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

  static List<ProfileDataModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProfileDataModel.fromJson).toList();
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["user"] is Map) {
      user = json["user"] == null ? null : User.fromJson(json["user"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
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
  String? activeTitle;
  int? active;
  Customer? customer;

  User({this.id, this.name, this.email, this.type, this.refreshToken, this.mobile, this.emailVerifiedAt, this.fcmToken, this.deactivatedBy, this.deactivatedAt, this.createdBy, this.createdAt, this.updatedAt, this.deletedAt, this.lastLoginAt, this.activeTitle, this.active, this.customer});

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
    if(json["active_title"] is String) {
      activeTitle = json["active_title"];
    }
    if(json["active"] is int) {
      active = json["active"];
    }
    if(json["customer"] is Map) {
      customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["type"] = type;
    _data["refresh_token"] = refreshToken;
    _data["mobile"] = mobile;
    _data["email_verified_at"] = emailVerifiedAt;
    _data["fcm_token"] = fcmToken;
    _data["deactivated_by"] = deactivatedBy;
    _data["deactivated_at"] = deactivatedAt;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["last_login_at"] = lastLoginAt;
    _data["active_title"] = activeTitle;
    _data["active"] = active;
    if(customer != null) {
      _data["customer"] = customer?.toJson();
    }
    return _data;
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
  String? universityNumber;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? typeTitle;
  dynamic genderTitle;
  String? imageUrl;
  List<dynamic>? documentsUrl;
  List<dynamic>? documentsId;
  List<Reservations>? reservations;
  List<Media>? media;

  Customer({this.id, this.userId, this.aboutMe, this.address, this.type, this.gender, this.age, this.dob, this.university, this.specialty, this.universityNumber, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle, this.genderTitle, this.imageUrl, this.documentsUrl, this.documentsId, this.reservations, this.media});

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
    if(json["reservations"] is List) {
      reservations = json["reservations"] == null ? null : (json["reservations"] as List).map((e) => Reservations.fromJson(e)).toList();
    }
    if(json["media"] is List) {
      media = json["media"] == null ? null : (json["media"] as List).map((e) => Media.fromJson(e)).toList();
    }
  }

  static List<Customer> fromList(List<Map<String, dynamic>> list) {
    return list.map(Customer.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["about_me"] = aboutMe;
    _data["address"] = address;
    _data["type"] = type;
    _data["gender"] = gender;
    _data["age"] = age;
    _data["dob"] = dob;
    _data["university"] = university;
    _data["specialty"] = specialty;
    _data["university_number"] = universityNumber;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["type_title"] = typeTitle;
    _data["gender_title"] = genderTitle;
    _data["image_url"] = imageUrl;
    if(documentsUrl != null) {
      _data["documents_url"] = documentsUrl;
    }
    if(documentsId != null) {
      _data["documents_id"] = documentsId;
    }
    if(reservations != null) {
      _data["reservations"] = reservations?.map((e) => e.toJson()).toList();
    }
    if(media != null) {
      _data["media"] = media?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  GeneratedConversions? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media({this.id, this.modelType, this.modelId, this.uuid, this.collectionName, this.name, this.fileName, this.mimeType, this.disk, this.conversionsDisk, this.size, this.manipulations, this.customProperties, this.generatedConversions, this.responsiveImages, this.orderColumn, this.createdAt, this.updatedAt, this.originalUrl, this.previewUrl});

  Media.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["model_type"] is String) {
      modelType = json["model_type"];
    }
    if(json["model_id"] is int) {
      modelId = json["model_id"];
    }
    if(json["uuid"] is String) {
      uuid = json["uuid"];
    }
    if(json["collection_name"] is String) {
      collectionName = json["collection_name"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["file_name"] is String) {
      fileName = json["file_name"];
    }
    if(json["mime_type"] is String) {
      mimeType = json["mime_type"];
    }
    if(json["disk"] is String) {
      disk = json["disk"];
    }
    if(json["conversions_disk"] is String) {
      conversionsDisk = json["conversions_disk"];
    }
    if(json["size"] is int) {
      size = json["size"];
    }
    if(json["manipulations"] is List) {
      manipulations = json["manipulations"] ?? [];
    }
    if(json["custom_properties"] is List) {
      customProperties = json["custom_properties"] ?? [];
    }
    if(json["generated_conversions"] is Map) {
      generatedConversions = json["generated_conversions"] == null ? null : GeneratedConversions.fromJson(json["generated_conversions"]);
    }
    if(json["responsive_images"] is List) {
      responsiveImages = json["responsive_images"] ?? [];
    }
    if(json["order_column"] is int) {
      orderColumn = json["order_column"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if(json["original_url"] is String) {
      originalUrl = json["original_url"];
    }
    if(json["preview_url"] is String) {
      previewUrl = json["preview_url"];
    }
  }

  static List<Media> fromList(List<Map<String, dynamic>> list) {
    return list.map(Media.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["model_type"] = modelType;
    _data["model_id"] = modelId;
    _data["uuid"] = uuid;
    _data["collection_name"] = collectionName;
    _data["name"] = name;
    _data["file_name"] = fileName;
    _data["mime_type"] = mimeType;
    _data["disk"] = disk;
    _data["conversions_disk"] = conversionsDisk;
    _data["size"] = size;
    if(manipulations != null) {
      _data["manipulations"] = manipulations;
    }
    if(customProperties != null) {
      _data["custom_properties"] = customProperties;
    }
    if(generatedConversions != null) {
      _data["generated_conversions"] = generatedConversions?.toJson();
    }
    if(responsiveImages != null) {
      _data["responsive_images"] = responsiveImages;
    }
    _data["order_column"] = orderColumn;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["original_url"] = originalUrl;
    _data["preview_url"] = previewUrl;
    return _data;
  }
}

class GeneratedConversions {
  bool? thumb;

  GeneratedConversions({this.thumb});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    if(json["thumb"] is bool) {
      thumb = json["thumb"];
    }
  }

  static List<GeneratedConversions> fromList(List<Map<String, dynamic>> list) {
    return list.map(GeneratedConversions.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["thumb"] = thumb;
    return _data;
  }
}

class Reservations {
  int? id;
  int? customerId;
  int? companyId;
  int? spaceId;
  dynamic roomId;
  int? recentStatusId;
  int? subscriptionId;
  String? paidAmount;
  int? seatsCount;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  dynamic note;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Reservations({this.id, this.customerId, this.companyId, this.spaceId, this.roomId, this.recentStatusId, this.subscriptionId, this.paidAmount, this.seatsCount, this.startDate, this.endDate, this.startTime, this.endTime, this.note, this.createdBy, this.createdAt, this.updatedAt, this.deletedAt});

  Reservations.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["customer_id"] is int) {
      customerId = json["customer_id"];
    }
    if(json["company_id"] is int) {
      companyId = json["company_id"];
    }
    if(json["space_id"] is int) {
      spaceId = json["space_id"];
    }
    roomId = json["room_id"];
    if(json["recent_status_id"] is int) {
      recentStatusId = json["recent_status_id"];
    }
    if(json["subscription_id"] is int) {
      subscriptionId = json["subscription_id"];
    }
    if(json["paid_amount"] is String) {
      paidAmount = json["paid_amount"];
    }
    if(json["seats_count"] is int) {
      seatsCount = json["seats_count"];
    }
    if(json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if(json["end_date"] is String) {
      endDate = json["end_date"];
    }
    if(json["start_time"] is String) {
      startTime = json["start_time"];
    }
    if(json["end_time"] is String) {
      endTime = json["end_time"];
    }
    note = json["note"];
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
  }

  static List<Reservations> fromList(List<Map<String, dynamic>> list) {
    return list.map(Reservations.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["customer_id"] = customerId;
    _data["company_id"] = companyId;
    _data["space_id"] = spaceId;
    _data["room_id"] = roomId;
    _data["recent_status_id"] = recentStatusId;
    _data["subscription_id"] = subscriptionId;
    _data["paid_amount"] = paidAmount;
    _data["seats_count"] = seatsCount;
    _data["start_date"] = startDate;
    _data["end_date"] = endDate;
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    _data["note"] = note;
    _data["created_by"] = createdBy;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}
