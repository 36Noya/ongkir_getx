import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir_getx/app/modules/home/views/widgets/city_widget.dart';
import 'package:ongkir_getx/app/modules/home/views/widgets/province_widget.dart';

import './widgets/city_widget.dart';
import './widgets/province_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ProvinceWidget(
            type: "asal",
          ),
          Obx(
            () => controller.hiddenCityFrom.isTrue
                ? SizedBox()
                : CityWidget(
                    provinceId: controller.provinceIdFrom.value,
                    type: "asal",
                  ),
          ),
          ProvinceWidget(
            type: "tujuan",
          ),
          Obx(
            () => controller.hiddenCityTo.isTrue
                ? SizedBox()
                : CityWidget(
                    provinceId: controller.provinceIdTo.value,
                    type: "tujuan",
                  ),
          ),
        ],
      ),
    );
  }
}
