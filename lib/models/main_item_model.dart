class MainItemsModel {
  List<SingleItem>? data;

  MainItemsModel({this.data});

  MainItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SingleItem>[];
      json['data'].forEach((v) {
        data!.add(new SingleItem.fromJson(v));
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

class SingleItem {
  int? id;
  String? code;
  String? commonName;
  String? scientificName;
  String? description;
  List<String>? images;
  List<String>? videos;

  SingleItem({this.id, this.code, this.commonName, this.scientificName, this.description, this.images, this.videos});

  SingleItem.fromJson(Map<String, dynamic> json) {
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
