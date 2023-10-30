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
}
