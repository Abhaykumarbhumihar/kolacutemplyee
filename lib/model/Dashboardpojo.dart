// To parse this JSON data, do
//
//     final dashboardpojo = dashboardpojoFromJson(jsonString);

import 'dart:convert';

Dashboardpojo dashboardpojoFromJson(String str) => Dashboardpojo.fromJson(json.decode(str));

String dashboardpojoToJson(Dashboardpojo data) => json.encode(data.toJson());

class Dashboardpojo {
  Dashboardpojo({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory Dashboardpojo.fromJson(Map<String, dynamic> json) => Dashboardpojo(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.orderReceved,
    this.completedOrder,
    this.totalEarnings,
    this.monthlyEarning,
  });

  int orderReceved;
  int completedOrder;
  int totalEarnings;
  int monthlyEarning;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderReceved: json["order_receved"],
    completedOrder: json["completed_order"],
    totalEarnings: json["total_earnings"],
    monthlyEarning: json["monthly_earning"],
  );

  Map<String, dynamic> toJson() => {
    "order_receved": orderReceved,
    "completed_order": completedOrder,
    "total_earnings": totalEarnings,
    "monthly_earning": monthlyEarning,
  };
}
