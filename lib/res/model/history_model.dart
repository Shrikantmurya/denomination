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
  int? value2000;
  int? valueCntr2000;
  int? value500;
  int? valueCntr500;
  int? value200;
  int? valueCntr200;

  Cashdata(
      {this.value2000,
      this.valueCntr2000,
      this.value500,
      this.valueCntr500,
      this.value200,
      this.valueCntr200});

  Cashdata.fromJson(Map<String, dynamic> json) {
    value2000 = json['value_2000'];
    valueCntr2000 = json['valueCntr_2000'];
    value500 = json['value_500'];
    valueCntr500 = json['valueCntr_500'];
    value200 = json['value_200'];
    valueCntr200 = json['valueCntr_200'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_2000'] = this.value2000;
    data['valueCntr_2000'] = this.valueCntr2000;
    data['value_500'] = this.value500;
    data['valueCntr_500'] = this.valueCntr500;
    data['value_200'] = this.value200;
    data['valueCntr_200'] = this.valueCntr200;
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
  int? valueCntr2000;
  int? valueCntr500;
  int? valueCntr200;
  int? valueCntr100;
  int? valueCntr50;
  int? valueCntr20;
  int? valueCntr10;
  int? valueCntr5;
  int? valueCntr2;
  int? valueCntr1;

  Cashvalue(
      {this.valueCntr2000,
      this.valueCntr500,
      this.valueCntr200,
      this.valueCntr100,
      this.valueCntr50,
      this.valueCntr20,
      this.valueCntr10,
      this.valueCntr5,
      this.valueCntr2,
      this.valueCntr1});

  Cashvalue.fromJson(Map<String, dynamic> json) {
    valueCntr2000 = json['valueCntr_2000'];
    valueCntr500 = json['valueCntr_500'];
    valueCntr200 = json['valueCntr_200'];
    valueCntr100 = json['valueCntr_100'];
    valueCntr50 = json['valueCntr_50'];
    valueCntr20 = json['valueCntr_20'];
    valueCntr10 = json['valueCntr_10'];
    valueCntr5 = json['valueCntr_5'];
    valueCntr2 = json['valueCntr_2'];
    valueCntr1 = json['valueCntr_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valueCntr_2000'] = this.valueCntr2000;
    data['valueCntr_500'] = this.valueCntr500;
    data['valueCntr_200'] = this.valueCntr200;
    data['valueCntr_100'] = this.valueCntr100;
    data['valueCntr_50'] = this.valueCntr50;
    data['valueCntr_20'] = this.valueCntr20;
    data['valueCntr_10'] = this.valueCntr10;
    data['valueCntr_5'] = this.valueCntr5;
    data['valueCntr_2'] = this.valueCntr2;
    data['valueCntr_1'] = this.valueCntr1;
    return data;
  }
}
