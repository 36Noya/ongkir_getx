import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkir_getx/app/modules/home/controllers/home_controller.dart';

import '../../../../data/models/city_model.dart';

class CityWidget extends GetView<HomeController> {
  const CityWidget({
    Key? key,
    required this.provinceId,
    required this.type,
  }) : super(key: key);

  final int provinceId;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<CityModel>(
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provinceId");
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

            var allCity = data['rajaongkir']['results'] as List<dynamic>;

            var models = CityModel.fromJsonList(allCity);
            return models;
          } catch (e) {
            print(e);
            return List<CityModel>.empty();
          }
        },
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (type == "asal") {
              controller.cityIdFrom.value = int.parse(cityValue.cityId!);
            } else {
              controller.cityIdTo.value = int.parse(cityValue.cityId!);
            }
          } else {
            if (type == "asal") {
              print("Tidak memilih kota/kabupaten asal manapun");
            } else {
              print("Tidak memilih kota/kabupaten tujuan manapun");
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
                "${item.type} ${item.cityName}",
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
              hintText: "Cari Kota/Kabupaten",
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
            labelText: type == "asal"
                ? "Kota/Kabupaten Asal"
                : "Kota/Kabupaten Tujuan",
            hintText: type == "asal"
                ? "Kota/Kabupaten Asal"
                : "Kota/Kabupaten Tujuan",
          ),
        ),
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
