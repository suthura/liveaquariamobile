class AvertisementsModel {
  List<SingleAvertisement>? data;

  AvertisementsModel({this.data});

  AvertisementsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SingleAvertisement>[];
      json['data'].forEach((v) {
        data!.add(new SingleAvertisement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleAvertisement {
  int? id;
  int? quantity;
  String? breedingCapacity;
  String? futureCollection;
  String? description;
  String? status;
  int? isPublish;
  List<String>? images;
  List<String>? videos;
  Item? item;

  SingleAvertisement(
      {this.id,
      this.quantity,
      this.breedingCapacity,
      this.futureCollection,
      this.description,
      this.status,
      this.isPublish,
      this.images,
      this.videos,
      this.item});

  SingleAvertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    breedingCapacity = json['breeding_capacity'];
    futureCollection = json['future_collection'];
    description = json['description'];
    status = json['status'];
    isPublish = json['is_publish'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['breeding_capacity'] = this.breedingCapacity;
    data['future_collection'] = this.futureCollection;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_publish'] = this.isPublish;
    data['images'] = this.images;
    data['videos'] = this.videos;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? code;
  String? commonName;
  String? scientificName;
  String? origin;
  String? color;
  String? size;
  String? description;
  List<String>? images;
  List<String>? videos;

  Item({this.id, this.code, this.commonName, this.scientificName, this.origin, this.color, this.size, this.description, this.images, this.videos});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    commonName = json['common_name'];
    scientificName = json['scientific_name'];
    origin = json['origin'];
    color = json['color'];
    size = json['size'];
    description = json['description'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['common_name'] = this.commonName;
    data['scientific_name'] = this.scientificName;
    data['origin'] = this.origin;
    data['color'] = this.color;
    data['size'] = this.size;
    data['description'] = this.description;
    data['images'] = this.images;
    data['videos'] = this.videos;
    return data;
  }
}
