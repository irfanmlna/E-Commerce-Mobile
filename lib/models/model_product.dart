// To parse this JSON data, do
//
//     final modelProduct = modelProductFromJson(jsonString);

import 'dart:convert';

ModelProduct modelProductFromJson(String str) =>
    ModelProduct.fromJson(json.decode(str));

String modelProductToJson(ModelProduct data) => json.encode(data.toJson());

class ModelProduct {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelProduct({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
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
  String productDesc;
  String productPrice;
  String productStock;
  String productImage;
  // String idCategory;

  Datum({
    required this.id,
    required this.productName,
    required this.productDesc,
    required this.productPrice,
    required this.productStock,
    required this.productImage,
    // required this.idCategory,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        productDesc: json["product_desc"],
        productPrice: json["product_price"],
        productStock: json["product_stock"],
        productImage: json["product_image"],
        // idCategory: json["id_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_desc": productDesc,
        "product_price": productPrice,
        "product_stock": productStock,
        "product_image": productImage,
        // "id_category": idCategory,
      };
}
