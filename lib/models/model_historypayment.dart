// To parse this JSON data, do
//
//     final modelPaymentHistory = modelPaymentHistoryFromJson(jsonString);

import 'dart:convert';

ModelPaymentHistory modelPaymentHistoryFromJson(String str) =>
    ModelPaymentHistory.fromJson(json.decode(str));

String modelPaymentHistoryToJson(ModelPaymentHistory data) =>
    json.encode(data.toJson());

class ModelPaymentHistory {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelPaymentHistory({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPaymentHistory.fromJson(Map<String, dynamic> json) =>
      ModelPaymentHistory(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String orderId;
  String amount;
  String customerAddress;
  String status;
  String snapToken;
  DateTime createdAt;
  String idUser;

  Datum({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.customerAddress,
    required this.status,
    required this.snapToken,
    required this.createdAt,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderId: json["order_id"],
        amount: json["amount"],
        customerAddress: json["customer_address"],
        status: json["status"],
        snapToken: json["snap_token"],
        createdAt: DateTime.parse(json["created_at"]),
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "amount": amount,
        "customer_address": customerAddress,
        "status": status,
        "snap_token": snapToken,
        "created_at": createdAt.toIso8601String(),
        "id_user": idUser,
      };
}
