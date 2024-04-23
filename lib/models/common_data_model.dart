class CommonDataModel {
  List<Countries>? countries;
  List<Timezones>? timezones;
  List<Currencies>? currencies;
  List<DeliveryMethods>? deliveryMethods;
  List<FishColors>? colors;
  List<FinTypes>? finTypes;
  List<TailTypes>? tailTypes;

  CommonDataModel({this.countries, this.timezones, this.currencies, this.deliveryMethods, this.colors, this.finTypes, this.tailTypes});

  CommonDataModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
    if (json['timezones'] != null) {
      timezones = <Timezones>[];
      json['timezones'].forEach((v) {
        timezones!.add(Timezones.fromJson(v));
      });
    }
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(Currencies.fromJson(v));
      });
    }
    if (json['delivery_methods'] != null) {
      deliveryMethods = <DeliveryMethods>[];
      json['delivery_methods'].forEach((v) {
        deliveryMethods!.add(DeliveryMethods.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <FishColors>[];
      json['colors'].forEach((v) {
        colors!.add(FishColors.fromJson(v));
      });
    }
    if (json['fin_types'] != null) {
      finTypes = <FinTypes>[];
      json['fin_types'].forEach((v) {
        finTypes!.add(FinTypes.fromJson(v));
      });
    }
    if (json['tail_types'] != null) {
      tailTypes = <TailTypes>[];
      json['tail_types'].forEach((v) {
        tailTypes!.add(TailTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    if (timezones != null) {
      data['timezones'] = timezones!.map((v) => v.toJson()).toList();
    }
    if (currencies != null) {
      data['currencies'] = currencies!.map((v) => v.toJson()).toList();
    }
    if (deliveryMethods != null) {
      data['delivery_methods'] = deliveryMethods!.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (finTypes != null) {
      data['fin_types'] = finTypes!.map((v) => v.toJson()).toList();
    }
    if (tailTypes != null) {
      data['tail_types'] = tailTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  String? code;

  Countries({this.id, this.name, this.code});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class Timezones {
  int? id;
  String? name;
  String? offset;

  Timezones({this.id, this.name, this.offset});

  Timezones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['offset'] = offset;
    return data;
  }
}

class Currencies {
  int? id;
  String? name;
  String? code;
  String? symbol;

  Currencies({this.id, this.name, this.code, this.symbol});

  Currencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    return data;
  }
}

class DeliveryMethods {
  int? id;
  String? name;

  DeliveryMethods({this.id, this.name});

  DeliveryMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class FishColors {
  int? id;
  String? name;

  FishColors({this.id, this.name});

  FishColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class FinTypes {
  int? id;
  String? name;

  FinTypes({this.id, this.name});

  FinTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TailTypes {
  int? id;
  String? name;

  TailTypes({this.id, this.name});

  TailTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
