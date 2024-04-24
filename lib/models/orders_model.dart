class OrdersModel {
  List<SingleOrder>? data;

  OrdersModel({this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SingleOrder>[];
      json['data'].forEach((v) {
        data!.add(new SingleOrder.fromJson(v));
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

class SingleOrder {
  int? id;
  String? type;
  int? quantity;
  String? address;
  String? status;
  String? note;
  Advertisement? advertisement;

  SingleOrder({this.id, this.type, this.quantity, this.address, this.status, this.note, this.advertisement});

  SingleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    quantity = json['quantity'];
    address = json['address'];
    status = json['status'];
    note = json['note'];
    advertisement = json['advertisement'] != null ? new Advertisement.fromJson(json['advertisement']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['address'] = this.address;
    data['status'] = this.status;
    data['note'] = this.note;
    if (this.advertisement != null) {
      data['advertisement'] = this.advertisement!.toJson();
    }
    return data;
  }
}

class Advertisement {
  int? id;
  String? gender;
  String? age;
  String? size;
  String? price;
  int? quantity;
  String? breedingCapacity;
  String? futureCollection;
  String? description;
  String? status;
  String? note;
  int? isPublish;
  List<String>? images;
  List<String>? videos;
  Item? item;
  Country? country;
  FishColor? color;
  FishColor? finType;
  FishColor? tailType;
  Supplier? supplier;

  Advertisement(
      {this.id,
      this.gender,
      this.age,
      this.size,
      this.price,
      this.quantity,
      this.breedingCapacity,
      this.futureCollection,
      this.description,
      this.status,
      this.note,
      this.isPublish,
      this.images,
      this.videos,
      this.item,
      this.country,
      this.color,
      this.finType,
      this.tailType,
      this.supplier});

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    age = json['age'];
    size = json['size'];
    price = json['price'];
    quantity = json['quantity'];
    breedingCapacity = json['breeding_capacity'];
    futureCollection = json['future_collection'];
    description = json['description'];
    status = json['status'];
    note = json['note'];
    isPublish = json['is_publish'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    country = json['country'] != null ? new Country.fromJson(json['country']) : null;
    color = json['color'] != null ? new FishColor.fromJson(json['color']) : null;
    finType = json['fin_type'] != null ? new FishColor.fromJson(json['fin_type']) : null;
    tailType = json['tail_type'] != null ? new FishColor.fromJson(json['tail_type']) : null;
    supplier = json['supplier'] != null ? new Supplier.fromJson(json['supplier']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['size'] = this.size;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['breeding_capacity'] = this.breedingCapacity;
    data['future_collection'] = this.futureCollection;
    data['description'] = this.description;
    data['status'] = this.status;
    data['note'] = this.note;
    data['is_publish'] = this.isPublish;
    data['images'] = this.images;
    data['videos'] = this.videos;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (this.finType != null) {
      data['fin_type'] = this.finType!.toJson();
    }
    if (this.tailType != null) {
      data['tail_type'] = this.tailType!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? code;
  String? commonName;
  String? scientificName;
  String? description;
  List<String>? images;
  List<String>? videos;

  Item({this.id, this.code, this.commonName, this.scientificName, this.description, this.images, this.videos});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    commonName = json['common_name'];
    scientificName = json['scientific_name'];
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
    data['description'] = this.description;
    data['images'] = this.images;
    data['videos'] = this.videos;
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? code;

  Country({this.id, this.name, this.code});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class FishColor {
  int? id;
  String? name;

  FishColor({this.id, this.name});

  FishColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Supplier {
  int? id;
  String? role;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  int? status;

  Supplier({this.id, this.role, this.name, this.email, this.phone, this.avatar, this.status});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    return data;
  }
}
