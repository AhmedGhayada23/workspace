
class ReservationModel{
  Data? data;
  String? message;
  bool? status;

  ReservationModel({this.data, this.message, this.status});

  ReservationModel.fromJson(Map<String, dynamic> json) {
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

  static List<ReservationModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(ReservationModel.fromJson).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json["data"] = data?.toJson(); // data هو كائن من نوع MyModel
    json["message"] = message;
    json["status"] = status;
    return json;
  }
}
class Data {
  List<Reservations>? reservations;
  Pagination? pagination;

  Data({this.reservations, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["reservations"] is List) {
      reservations = json["reservations"] == null ? null : (json["reservations"] as List).map((e) => Reservations.fromJson(e)).toList();
    }
    if(json["pagination"] is Map) {
      pagination = json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(reservations != null) {
      data["reservations"] = reservations?.map((e) => e.toJson()).toList();
    }
    if(pagination != null) {
      data["pagination"] = pagination?.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["current_page"] = currentPage;
    data["last_page"] = lastPage;
    data["per_page"] = perPage;
    data["total"] = total;
    return data;
  }
}

class Reservations {
  int? id;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? seatsCount;
  String? paidAmount;
  int? recentStatusId;
  Status? status;
  dynamic note;
  Space? space;
  String? createdAt;
  List<dynamic>? intervals;
  Company? company;
  Room? room;
  Customer? customer;
  Subscription? subscription;

  Reservations({this.id, this.startDate, this.endDate, this.startTime, this.endTime, this.seatsCount, this.paidAmount, this.recentStatusId, this.status, this.note, this.space, this.createdAt, this.intervals, this.company, this.room, this.customer, this.subscription});

  Reservations.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
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
    if(json["seats_count"] is int) {
      seatsCount = json["seats_count"];
    }
    if(json["paid_amount"] is String) {
      paidAmount = json["paid_amount"];
    }
    if(json["recent_status_id"] is int) {
      recentStatusId = json["recent_status_id"];
    }
    if(json["status"] is Map) {
      status = json["status"] == null ? null : Status.fromJson(json["status"]);
    }
    note = json["note"];
    if(json["space"] is Map) {
      space = json["space"] == null ? null : Space.fromJson(json["space"]);
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["intervals"] is List) {
      intervals = json["intervals"] ?? [];
    }
    if(json["company"] is Map) {
      company = json["company"] == null ? null : Company.fromJson(json["company"]);
    }
    if(json["room"] is Map) {
      room = json["room"] == null ? null : Room.fromJson(json["room"]);
    }
    if(json["customer"] is Map) {
      customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }
    if(json["subscription"] is Map) {
      subscription = json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]);
    }
  }

  static List<Reservations> fromList(List<Map<String, dynamic>> list) {
    return list.map(Reservations.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["start_date"] = startDate;
    data["end_date"] = endDate;
    data["start_time"] = startTime;
    data["end_time"] = endTime;
    data["seats_count"] = seatsCount;
    data["paid_amount"] = paidAmount;
    data["recent_status_id"] = recentStatusId;
    if(status != null) {
      data["status"] = status?.toJson();
    }
    data["note"] = note;
    if(space != null) {
      data["space"] = space?.toJson();
    }
    data["created_at"] = createdAt;
    if(intervals != null) {
      data["intervals"] = intervals;
    }
    if(company != null) {
      data["company"] = company?.toJson();
    }
    if(room != null) {
      data["room"] = room?.toJson();
    }
    if(customer != null) {
      data["customer"] = customer?.toJson();
    }
    if(subscription != null) {
      data["subscription"] = subscription?.toJson();
    }
    return data;
  }
}

class Subscription {
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

  Subscription({this.id, this.spaceId, this.type, this.price, this.customersCount, this.createdBy, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle});

  Subscription.fromJson(Map<String, dynamic> json) {
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

  static List<Subscription> fromList(List<Map<String, dynamic>> list) {
    return list.map(Subscription.fromJson).toList();
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

class Customer {
  int? id;
  String? name;
  String? mobile;
  String? imageUrl;
  String? typeTitle;

  Customer({this.id, this.name, this.mobile, this.imageUrl, this.typeTitle});

  Customer.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if(json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if(json["type_title"] is String) {
      typeTitle = json["type_title"];
    }
  }

  static List<Customer> fromList(List<Map<String, dynamic>> list) {
    return list.map(Customer.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["mobile"] = mobile;
    data["image_url"] = imageUrl;
    data["type_title"] = typeTitle;
    return data;
  }
}

class Room {
  dynamic id;
  dynamic name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  static List<Room> fromList(List<Map<String, dynamic>> list) {
    return list.map(Room.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? ownerName;
  String? ownerImageUrl;

  Company({this.id, this.companyName, this.ownerName, this.ownerImageUrl});

  Company.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["company_name"] is String) {
      companyName = json["company_name"];
    }
    if(json["owner_name"] is String) {
      ownerName = json["owner_name"];
    }
    if(json["owner_image_url"] is String) {
      ownerImageUrl = json["owner_image_url"];
    }
  }

  static List<Company> fromList(List<Map<String, dynamic>> list) {
    return list.map(Company.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["company_name"] = companyName;
    data["owner_name"] = ownerName;
    data["owner_image_url"] = ownerImageUrl;
    return data;
  }
}

class Space {
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
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? mainImageUrl;
  dynamic videoUrl;
  dynamic videoId;
  List<int>? imagesId;
  List<String>? imagesUrl;
  double? ratingAverage;
  int? ratingCount;
  List<Evaluations>? evaluations;
  List<Media>? media;

  Space({this.id, this.companyId, this.provinceId, this.content, this.availableFrom, this.availableTo, this.email, this.mobile, this.address, this.roomsCount, this.seatsCount, this.customersCount, this.createdBy, this.createdAt, this.updatedAt, this.deletedAt, this.mainImageUrl, this.videoUrl, this.videoId, this.imagesId, this.imagesUrl, this.ratingAverage, this.ratingCount, this.evaluations, this.media});

  Space.fromJson(Map<String, dynamic> json) {
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
    if(json["main_image_url"] is String) {
      mainImageUrl = json["main_image_url"];
    }
    videoUrl = json["video_url"];
    videoId = json["video_id"];
    if(json["images_id"] is List) {
      imagesId = json["images_id"] == null ? null : List<int>.from(json["images_id"]);
    }
    if(json["images_url"] is List) {
      imagesUrl = json["images_url"] == null ? null : List<String>.from(json["images_url"]);
    }
    if(json["rating_average"] is double) {
      ratingAverage = json["rating_average"];
    }
    if(json["rating_count"] is int) {
      ratingCount = json["rating_count"];
    }
    if(json["evaluations"] is List) {
      evaluations = json["evaluations"] == null ? null : (json["evaluations"] as List).map((e) => Evaluations.fromJson(e)).toList();
    }
    if(json["media"] is List) {
      media = json["media"] == null ? null : (json["media"] as List).map((e) => Media.fromJson(e)).toList();
    }
  }

  static List<Space> fromList(List<Map<String, dynamic>> list) {
    return list.map(Space.fromJson).toList();
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
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["main_image_url"] = mainImageUrl;
    data["video_url"] = videoUrl;
    data["video_id"] = videoId;
    if(imagesId != null) {
      data["images_id"] = imagesId;
    }
    if(imagesUrl != null) {
      data["images_url"] = imagesUrl;
    }
    data["rating_average"] = ratingAverage;
    data["rating_count"] = ratingCount;
    if(evaluations != null) {
      data["evaluations"] = evaluations?.map((e) => e.toJson()).toList();
    }
    if(media != null) {
      data["media"] = media?.map((e) => e.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["model_type"] = modelType;
    data["model_id"] = modelId;
    data["uuid"] = uuid;
    data["collection_name"] = collectionName;
    data["name"] = name;
    data["file_name"] = fileName;
    data["mime_type"] = mimeType;
    data["disk"] = disk;
    data["conversions_disk"] = conversionsDisk;
    data["size"] = size;
    if(manipulations != null) {
      data["manipulations"] = manipulations;
    }
    if(customProperties != null) {
      data["custom_properties"] = customProperties;
    }
    if(generatedConversions != null) {
      data["generated_conversions"] = generatedConversions?.toJson();
    }
    if(responsiveImages != null) {
      data["responsive_images"] = responsiveImages;
    }
    data["order_column"] = orderColumn;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["original_url"] = originalUrl;
    data["preview_url"] = previewUrl;
    return data;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["thumb"] = thumb;
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

  Evaluations({this.id, this.customerId, this.spaceId, this.value, this.message, this.type, this.createdAt, this.updatedAt, this.deletedAt, this.typeTitle});

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
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Status({this.id, this.name, this.createdAt, this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if(json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  static List<Status> fromList(List<Map<String, dynamic>> list) {
    return list.map(Status.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
