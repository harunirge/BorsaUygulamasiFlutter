/* class ConvertModel {
  bool? success;
  Resultt? result;

  ConvertModel({this.success, this.result});

  ConvertModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? new Resultt.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Resultt {
  String? base;
  String? lastupdate;
  List<Data>? data;

  Resultt({this.base, this.lastupdate, this.data});

  Resultt.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    lastupdate = json['lastupdate'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    data['lastupdate'] = this.lastupdate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? code;
  String? name;
  int? rate;
  String? calculatedstr;
  int? calculated;

  Data({this.code, this.name, this.rate, this.calculatedstr, this.calculated});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    rate = json['rate']== null ? 0 : json['rate'].toInt();
    calculatedstr = json['calculatedstr'];
    calculated = json['calculated']== null ? 0 : json['calculated'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['calculatedstr'] = this.calculatedstr;
    data['calculated'] = this.calculated;
    return data;
  }
} */