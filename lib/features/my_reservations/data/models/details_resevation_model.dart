class DetailsResevationModel {
  Data? data;
  String? message;
  bool? status;

  DetailsResevationModel({this.data, this.message, this.status});

  DetailsResevationModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<DetailsResevationModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DetailsResevationModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data["data"] = data.toJson();
    data["message"] = message;
    data["status"] = status;
    return data;
  }
}

class Data {
  Reservation? reservation;

  Data({this.reservation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["reservation"] is Map) {
      reservation = json["reservation"] == null ? null : Reservation.fromJson(json["reservation"]);
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reservation != null) {
      data["reservation"] = reservation?.toJson();
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

class Reservation {
  int? id;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  dynamic endTime;
  int? seatsCount;
  String? paidAmount;
  int? recentStatusId;
  Status? status;
  dynamic note;
  String? createdAt;
  List<Intervals>? intervals;
  Subscription? subscription;
  Room? room;

  Reservation({
    this.id,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.seatsCount,
    this.paidAmount,
    this.recentStatusId,
    this.status,
    this.note,
    this.createdAt,
    this.intervals,
    this.subscription,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    startDate = json["start_date"];
    endDate = json["end_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    if (json["seats_count"] is int) {
      seatsCount = json["seats_count"];
    }
    if (json["paid_amount"] is String) {
      paidAmount = json["paid_amount"];
    }
    if (json["recent_status_id"] is int) {
      recentStatusId = json["recent_status_id"];
    }
    if (json["status"] is Map) {
      status = json["status"] == null ? null : Status.fromJson(json["status"]);
    }
    note = json["note"];

    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["intervals"] is List) {
      intervals =
          json["intervals"] == null
              ? null
              : (json["intervals"] as List).map((e) => Intervals.fromJson(e)).toList();
    }

    if (json["room"] is Map) {
      room = json["room"] == null ? null : Room.fromJson(json["room"]);
    }
     if (json["subscription"] is Map) {
      subscription = json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]);
    }

  }

  static List<Reservation> fromList(List<Map<String, dynamic>> list) {
    return list.map(Reservation.fromJson).toList();
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
    if (status != null) {
      data["status"] = status?.toJson();
    }
    data["note"] = note;

    data["created_at"] = createdAt;
    if (intervals != null) {
      data["intervals"] = intervals?.map((e) => e.toJson()).toList();
    }
    if (room != null) {
      data["room"] = room?.toJson();
    }

    return data;
  }
}

class Room {
  int? id;
  String? name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
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

class Subscription {
  final int id;
  final int spaceId;
  final String type;
  final String price;
  final int customersCount;
  final String typeTitle;

  Subscription({
    required this.id,
    required this.spaceId,
    required this.type,
    required this.price,
    required this.customersCount,
    required this.typeTitle,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json['id'],
        spaceId: json['space_id'],
        type: json['type'],
        price: json['price'],
        customersCount: json['customers_count'],
        typeTitle: json['type_title'],
      );
}

class Intervals {
  int? id;
  int? reservationId;
  int? intervalId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic availableFrom;
  dynamic availableTo;
  String? periodTitle;
  String? dayTitle;

  Intervals({
    this.id,
    this.reservationId,
    this.intervalId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.availableFrom,
    this.availableTo,
    this.periodTitle,
    this.dayTitle,
  });

  Intervals.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["reservation_id"] is int) {
      reservationId = json["reservation_id"];
    }
    if (json["interval_id"] is int) {
      intervalId = json["interval_id"];
    }
    if (json["created_by"] is int) {
      createdBy = json["created_by"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    deletedAt = json["deleted_at"];

    if (json["available_from"] is String) {
      availableFrom = json["available_from"];
    }
    if (json["available_to"] is String) {
      availableTo = json["available_to"];
    }

    periodTitle = json["period_title"];
    dayTitle = json["day_title"];
  }

  static List<Intervals> fromList(List<Map<String, dynamic>> list) {
    return list.map(Intervals.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["reservation_id"] = reservationId;
    data["interval_id"] = intervalId;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["available_from"] = availableFrom;
    data["available_to"] = availableTo;
    data["period_title"] = periodTitle;
    data["day_title"] = dayTitle;



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
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
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
