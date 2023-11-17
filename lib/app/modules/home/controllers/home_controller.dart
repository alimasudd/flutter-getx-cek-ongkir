import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cek_ongkir/app/data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();
  RxString provAsalId = '0'.obs;
  RxString cityAsalId = '0'.obs;
  RxString provTujuanId = '0'.obs;
  RxString cityTujuanId = '0'.obs;

  RxString codeKurir = ''.obs;
  RxBool isLoading = false.obs;

  List<Ongkir> ongkosKirim = [];

  void cekOngkir() async {
    if(provAsalId.value != '0' && cityAsalId.value != '0' && provTujuanId.value != '0' && cityTujuanId.value != '0' && codeKurir.value != '0'){
      try{
        isLoading.value = true;
        var response = await Dio().post('https://api.rajaongkir.com/starter/cost',
          options: Options(
            headers: {
              'content-type' : 'application/x-www-form-urlencoded',
              'key' : '0ae702200724a396a933fa0ca4171a7e'
            }
          ),
        );

        isLoading.value = false;
        List ongkir = response.data['rajaongkir']['results'][0]['costs'] as List;
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
          title: 'Ongkos Kirim',
          content: Column(
            children: ongkosKirim.map((e) => ListTile(
              title: Text(e.service!.toUpperCase()),
              subtitle: Text('Rp ${e.cost![0].value}'),
            )).toList(),
          )
        );

      }catch(e){
        print(e);
        Get.defaultDialog(
          title: "Kesalahan",
          middleText: "Cek Ongkir Gagal",
        );
      }


    }else{
      Get.defaultDialog(
        title: "Kesalahan",
        middleText: "Data Input Belum Lengkap",
      );
    }
  }
}
