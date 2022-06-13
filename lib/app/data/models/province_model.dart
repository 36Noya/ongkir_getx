// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) =>
    ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    this.provinceId,
    this.province,
  });

  String? provinceId;
  String? province;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };
  static List<ProvinceModel> fromJsonList(List list) {
    if (list.isEmpty) return List<ProvinceModel>.empty();
    return list.map((item) => ProvinceModel.fromJson(item)).toList();
  }
}
