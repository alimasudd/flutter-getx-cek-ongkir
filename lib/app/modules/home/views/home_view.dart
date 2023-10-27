import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_cek_ongkir/app/data/models/province_model.dart';

import '../../../data/models/city_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Ongkir'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          //provinsi asal
          DropdownSearch<Province>(
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.province}'),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Provinsi Asal',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                "https://api.rajaongkir.com/starter/province",
                options: Options(
                  headers: {
                    'key' : '0ae702200724a396a933fa0ca4171a7e'
                  }
                )
              );
              var models = Province.fromJsonList(response.data['rajaongkir']['results']);
              return models;
            },
            onChanged: (value) => controller.provAsalId.value = value!.provinceId ?? '0',
          ),
          SizedBox(height: 20,),
        ],
      )
    );
  }
}
