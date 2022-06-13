import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/province_model.dart';
import '../../controllers/home_controller.dart';

class ProvinceWidget extends GetView<HomeController> {
  const ProvinceWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<ProvinceModel>(
        asyncItems: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final response = await http.get(
              url,
              headers: {
                "key": "ac445fa14f4e72086af4ae19f59097df",
              },
            );
            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data['rajaongkir']['status']['code'];

            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var allProvince = data['rajaongkir']['results'] as List<dynamic>;

            var models = ProvinceModel.fromJsonList(allProvince);
            return models;
          } catch (e) {
            print(e);
            return List<ProvinceModel>.empty();
          }
        },
        onChanged: (provinceValue) {
          if (provinceValue != null) {
            if (type == "asal") {
              controller.hiddenCityFrom.value = false;
              controller.provinceIdFrom.value =
                  int.parse(provinceValue.provinceId!);
            } else {
              controller.hiddenCityTo.value = false;
              controller.provinceIdTo.value =
                  int.parse(provinceValue.provinceId!);
            }
          } else {
            if (type == "asal") {
              controller.hiddenCityFrom.value = true;
              controller.provinceIdFrom.value = 0;
            } else {
              controller.hiddenCityTo.value = true;
              controller.provinceIdTo.value = 0;
            }
          }
        },
        popupProps: PopupProps.menu(
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                "${item.province}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          },
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Cari Provinsi",
            ),
          ),
        ),
        clearButtonProps: ClearButtonProps(
          isVisible: true,
          padding: EdgeInsets.all(0),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: type == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
            hintText: type == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
          ),
        ),
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
