class BtnModel {
  int? id;
  String? name;

  

  String? image;

  BtnModel({this.id, this.name,this.image});

  BtnModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    

    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    

    _data['image'] = image;

    return _data;
  }
}
