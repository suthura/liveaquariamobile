class SubUserModel {
  List<SubUser>? data;

  SubUserModel({this.data});

  SubUserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubUser>[];
      json['data'].forEach((v) {
        data!.add(new SubUser.fromJson(v));
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

class SubUser {
  int? id;
  String? role;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  int? status;

  SubUser({this.id, this.role, this.name, this.email, this.phone, this.avatar, this.status});

  SubUser.fromJson(Map<String, dynamic> json) {
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
