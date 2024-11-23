import 'dart:convert';

class HistoryListModel {
  Cashdata? cashdata;
  List<RetrievedData>? retrievedData;

  HistoryListModel({this.cashdata, this.retrievedData});

  HistoryListModel.fromJson(Map<String, dynamic> json) {
    cashdata = json['cashdata'] != null
        ? new Cashdata.fromJson(json['cashdata'])
        : null;
    if (json['retrievedData'] != null) {
      retrievedData = <RetrievedData>[];
      json['retrievedData'].forEach((v) {
        retrievedData!.add(new RetrievedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cashdata != null) {
      data['cashdata'] = this.cashdata!.toJson();
    }
    if (this.retrievedData != null) {
      data['retrievedData'] =
          this.retrievedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cashdata {
  List<int>? value2000;
  List<int>? value500;

  Cashdata({this.value2000, this.value500});

  Cashdata.fromJson(Map<String, dynamic> json) {
    value2000 = json['value_2000'].cast<int>();
    value500 = json['value_500'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_2000'] = this.value2000;
    data['value_500'] = this.value500;
    return data;
  }
}

class RetrievedData {
  int? id;
  String? name;
  double? total;
  String? category;
  String? date;
  String? time;
  Cashvalue? cashvalue;

  RetrievedData({
    this.id,
    this.name,
    this.total,
    this.category,
    this.date,
    this.time,
    this.cashvalue,
  });

  RetrievedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'] is String
        ? double.tryParse(json['total'])
        : json['total']?.toDouble();
    category = json['category'];
    date = json['date'];
    time = json['time'];

    if (json['cashvalue'] != null) {
      if (json['cashvalue'] is String) {
        try {
          String formattedJson = json['cashvalue'];
          if (formattedJson.startsWith("{") && formattedJson.endsWith("}")) {
            cashvalue = Cashvalue.fromJson(jsonDecode(formattedJson));
          } else {
            print("Invalid cashvalue string: $formattedJson");
          }
        } catch (e) {
          print("Error decoding cashvalue: $e");
        }
      } else if (json['cashvalue'] is Map) {
        cashvalue = Cashvalue.fromJson(json['cashvalue']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['total'] = this.total;
    data['category'] = this.category;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.cashvalue != null) {
      data['cashvalue'] = this.cashvalue!.toJson();
    }
    return data;
  }
}

class Cashvalue {
  List<int>? value2000;
  List<int>? value500;
  List<int>? value100;
  List<int>? value50;
  List<int>? value20;
  List<int>? value10;
  List<int>? value5;
  List<int>? value2;
  List<int>? value1;

  Cashvalue(
      {this.value2000,
      this.value500,
      this.value100,
      this.value50,
      this.value20,
      this.value10,
      this.value5,
      this.value2,
      this.value1});

  Cashvalue.fromJson(Map<String, dynamic> json) {
    value2000 = json['value_2000'].cast<int>();
    value500 = json['value_500'].cast<int>();
    value100 = json['value_100'].cast<int>();
    value50 = json['value_50'].cast<int>();
    value20 = json['value_20'].cast<int>();
    value10 = json['value_10'].cast<int>();
    value5 = json['value_5'].cast<int>();
    value2 = json['value_2'].cast<int>();
    value1 = json['value_1'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_2000'] = this.value2000;
    data['value_500'] = this.value500;
    data['value_100'] = this.value100;
    data['value_50'] = this.value50;
    data['value_20'] = this.value20;
    data['value_10'] = this.value10;
    data['value_5'] = this.value5;
    data['value_2'] = this.value2;
    data['value_1'] = this.value1;
    return data;
  }
}
