// To parse this JSON data, do
//
//     final modelCart = modelCartFromJson(jsonString);

import 'dart:convert';

ModelCart modelCartFromJson(String str) => ModelCart.fromJson(json.decode(str));

String modelCartToJson(ModelCart data) => json.encode(data.toJson());

class ModelCart {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelCart({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
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
  String productName;
  String productImage;
  String productDesc;
  String productPrice;
  int productStock;

  Datum({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productDesc,
    required this.productPrice,
    this.productStock = 1,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productDesc: json["product_desc"],
        productPrice: json["product_price"],
        productStock: json["product_stock"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_image": productImage,
        "product_desc": productDesc,
        "product_price": productPrice,
        "product_stock": productStock,
      };
}
