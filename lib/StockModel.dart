class LiveStockModel {
  bool? success;
  List<Result>? result;

  LiveStockModel({this.success, this.result});

  LiveStockModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? currency;
  String? name;
  String? pricestr;
  double? price;
  double? rate;
  String? time;

  Result(
      {this.currency,
        this.name,
        this.pricestr,
        this.price,
        this.rate,
        this.time});

  Result.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    name = json['name'];
    pricestr = json['pricestr'];
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
    rate = json['rate'] == null ? 0.0 : json ['rate'].toDouble();
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['name'] = this.name;
    data['pricestr'] = this.pricestr;
    data['price'] = this.price;
    data['rate'] = this.rate;
    data['time'] = this.time;
    return data;
  }
}