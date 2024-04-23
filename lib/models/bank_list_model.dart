class BankListModel {
  List<SingleBankData>? data;

  BankListModel({this.data});

  BankListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SingleBankData>[];
      json['data'].forEach((v) {
        data!.add(SingleBankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleBankData {
  int? id;
  String? name;
  String? code;
  List<BankBranches>? bankBranches;

  SingleBankData({this.id, this.name, this.code, this.bankBranches});

  SingleBankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    if (json['bank_branches'] != null) {
      bankBranches = <BankBranches>[];
      json['bank_branches'].forEach((v) {
        bankBranches!.add(BankBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    if (bankBranches != null) {
      data['bank_branches'] = bankBranches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankBranches {
  int? id;
  String? name;
  String? code;

  BankBranches({this.id, this.name, this.code});

  BankBranches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
