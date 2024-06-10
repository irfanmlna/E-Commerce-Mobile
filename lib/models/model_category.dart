// To parse this JSON data, do
//
//     final modelCategory = modelCategoryFromJson(jsonString);

import 'dart:convert';

ModelCategory modelCategoryFromJson(String str) =>
    ModelCategory.fromJson(json.decode(str));

String modelCategoryToJson(ModelCategory data) => json.encode(data.toJson());

class ModelCategory {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelCategory({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelCategory.fromJson(Map<String, dynamic> json) => ModelCategory(
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
  String categoryName;
  String imagecat;
  String jumlah;

  Datum({
    required this.id,
    required this.categoryName,
    required this.imagecat,
    required this.jumlah,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"],
        imagecat: json["imagecat"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "imagecat": imagecat,
        "jumlah": jumlah,
      };
}
