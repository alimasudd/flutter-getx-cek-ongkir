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

          //kota asal
          DropdownSearch<City>(
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.type} ${item.cityName}'),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Kota Asal',
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId.value}",
                  options: Options(
                      headers: {
                        'key' : '0ae702200724a396a933fa0ca4171a7e'
                      }
                  )
              );
              var models = City.fromJsonList(response.data['rajaongkir']['results']);
              return models;
            },
            onChanged: (value) => controller.cityAsalId.value = value!.cityId ?? '0',
          ),
          const SizedBox(height: 20,),

          //provinsi tujuan
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
                labelText: 'Provinsi Tujuan',
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
            onChanged: (value) => controller.provTujuanId.value = value!.provinceId ?? '0',
          ),
          const SizedBox(height: 20,),

          //kota tujuan
          DropdownSearch<City>(
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item.type} ${item.cityName}'),
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Kota Tujuan',
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15
                ),
                border: OutlineInputBorder(),
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId.value}",
                  options: Options(
                      headers: {
                        'key' : '0ae702200724a396a933fa0ca4171a7e'
                      }
                  )
              );
              var models = City.fromJsonList(response.data['rajaongkir']['results']);
              return models;
            },
            onChanged: (value) => controller.cityTujuanId.value = value!.cityId ?? '0',
          ),
          const SizedBox(height: 20,),

          //berat
          TextField(
            controller: controller.beratC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              labelText: 'Berat (gram)',
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15
              )
            ),
          ),
          const SizedBox(height: 20,),

          //pilih kurir
          DropdownSearch<Map<String,dynamic>>(
            items: const [
              {
                'code': 'jne',
                'name': 'JNE'
              },
              {
                'code': 'pos',
                'name': 'POS Indonesia'
              },
              {
                'code': 'tiki',
                'name': 'TIKI'
              },
              ],
            popupProps: PopupProps.dialog(
              fit: FlexFit.loose,
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text('${item['name']}'),
              ),
            ),
            onChanged: (value) => controller.codeKurir.value = value!['code'] ?? '',
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: 'Pilih Kurir',
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15
                ),
                border: OutlineInputBorder(),
              ),
            ),
            dropdownBuilder: (context, selectedItem) => Text('${selectedItem?['name'] ?? 'Pilih Kurir'}'),
          ),
          const SizedBox(height: 50,),

          Obx(() {
          return ElevatedButton(
              onPressed: (){
                if(controller.isLoading.isFalse){
                  controller.cekOngkir();
                }
              },
              child: Text(controller.isLoading.isFalse ? 'Cek Ongkos Kirim' : 'Loading'));
})
        ],
      )
    );
  }
}
