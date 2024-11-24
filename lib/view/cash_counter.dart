import 'dart:convert';
import 'dart:io';

import 'package:denomination/view/savedialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import '../res/assets/image_assets.dart';
import '../res/colors/app_color.dart';
import '../res/components/button.dart';
import '../res/components/currencyrow.dart';
import '../res/routes/routes_name.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../utils/utils.dart';

class CashCounter extends StatefulWidget {
  const CashCounter({super.key});

  @override
  State<CashCounter> createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  RxInt rs2000 = 0.obs;
  RxInt rs500 = 0.obs;
  RxInt rs200 = 0.obs;
  RxInt rs100 = 0.obs;
  RxInt rs50 = 0.obs;
  RxInt rs20 = 0.obs;
  RxInt rs10 = 0.obs;
  RxInt rs5 = 0.obs;
  RxInt rs2 = 0.obs;
  RxInt rs1 = 0.obs;

  RxInt rs2000Note = 0.obs;
  RxInt rs500Note = 0.obs;
  RxInt rs200Note = 0.obs;
  RxInt rs100Note = 0.obs;
  RxInt rs50Note = 0.obs;
  RxInt rs20Note = 0.obs;
  RxInt rs10Note = 0.obs;
  RxInt rs5Note = 0.obs;
  RxInt rs2Note = 0.obs;
  RxInt rs1Note = 0.obs;
  RxBool cashImage_old = false.obs;
  List<bool> isSelected = [true, false];

  final formatCurrency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  );
  TextEditingController rs2000Controller = TextEditingController();
  TextEditingController rs500Controller = TextEditingController();
  TextEditingController rs200Controller = TextEditingController();
  TextEditingController rs100Controller = TextEditingController();
  TextEditingController rs50Controller = TextEditingController();
  TextEditingController rs20Controller = TextEditingController();
  TextEditingController rs10Controller = TextEditingController();
  TextEditingController rs5Controller = TextEditingController();
  TextEditingController rs2Controller = TextEditingController();
  TextEditingController rs1Controller = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Future<bool> showExitPopup(context) async {
    exit(0);
  }

  final ThemeController themeController =
      Get.find(); // Access the ThemeController
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: MaterialApp(
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 41, 41, 41),
          body: Obx(
            () => Column(
              children: [
                Container(
                  width: width,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(
                        ImageAssets.bannerImage,
                      ), // Replace with asset
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert,
                              color: Colors.white, size: 20),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: Theme.of(context).primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text("History",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white)),
                                ],
                              ),
                              onTap: () {
                                Get.toNamed(RouteName.history);
                              },
                            ),
                          ],
                          color: const Color(0xFF464646),
                          elevation: 2,
                        ),
                      ),
                      ((rs1.value +
                                  rs2.value +
                                  rs5.value +
                                  rs10.value +
                                  rs20.value +
                                  rs50.value +
                                  rs100.value +
                                  rs200.value +
                                  rs500.value +
                                  rs2000.value) !=
                              0)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text('Total Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                      formatCurrency
                                          .format(
                                            rs1.value +
                                                rs2.value +
                                                rs5.value +
                                                rs10.value +
                                                rs20.value +
                                                rs50.value +
                                                rs100.value +
                                                rs200.value +
                                                rs500.value +
                                                rs2000.value,
                                          )
                                          .split('.')[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15.0),
                                  child: Text(
                                      '${Utils.convertNumberToWords(rs1.value + rs2.value + rs5.value + rs10.value + rs20.value + rs50.value + rs100.value + rs200.value + rs500.value + rs2000.value)} Only/-',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                              ],
                            )
                          : const Padding(
                              padding: EdgeInsets.only(bottom: 20, left: 15),
                              child: Text(
                                'Denomination',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .74,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CurrencyRow(
                          controller: rs2000Controller,
                          label: '₹  2000 X',
                          onChanged: (value) {
                            rs500.value = 2000 *
                                (value.isNotEmpty ? int.parse(value) : 0);
                            rs2000Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs2000,
                        ),
                        CurrencyRow(
                          controller: rs500Controller,
                          label: '₹   500 X',
                          onChanged: (value) {
                            rs500.value =
                                500 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs500Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs500,
                        ),
                        CurrencyRow(
                          controller: rs200Controller,
                          label: '₹    200 X',
                          onChanged: (value) {
                            rs200.value =
                                200 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs200Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs200,
                        ),
                        CurrencyRow(
                          controller: rs100Controller,
                          label: '₹    100 X',
                          onChanged: (value) {
                            rs100.value =
                                100 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs100Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs100,
                        ),
                        CurrencyRow(
                          controller: rs50Controller,
                          label: '₹    50   X',
                          onChanged: (value) {
                            rs50.value =
                                50 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs50Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs50,
                        ),
                        CurrencyRow(
                          controller: rs20Controller,
                          label: '₹    20   X',
                          onChanged: (value) {
                            rs20.value =
                                20 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs20Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs20,
                        ),
                        CurrencyRow(
                          controller: rs10Controller,
                          label: '₹    10   X',
                          onChanged: (value) {
                            rs10.value =
                                10 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs10Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs10,
                        ),
                        CurrencyRow(
                          controller: rs5Controller,
                          label: '₹    5     X',
                          onChanged: (value) {
                            rs5.value =
                                5 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs5Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs5,
                        ),
                        CurrencyRow(
                          controller: rs2Controller,
                          label: '₹    2     X',
                          onChanged: (value) {
                            rs2.value =
                                2 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs2Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs2,
                        ),
                        CurrencyRow(
                          controller: rs1Controller,
                          label: '₹    1     X',
                          onChanged: (value) {
                            rs1.value =
                                1 * (value.isNotEmpty ? int.parse(value) : 0);
                            rs1Note.value =
                                value.isNotEmpty ? int.parse(value) : 0;
                          },
                          result: rs1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: (rs1.value +
                      rs2.value +
                      rs5.value +
                      rs10.value +
                      rs20.value +
                      rs50.value +
                      rs100.value +
                      rs200.value +
                      rs500.value +
                      rs2000.value) !=
                  0
              ? SizedBox(
                  width: 70, // Diameter of the circle
                  height: 70, // Diameter of the circle
                  child: FloatingActionButton(
                    onPressed: () {
                      print("Floating Circle Button Pressed");
                    },
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor:
                            Theme.of(context).primaryColor, // Background color
                      ),
                      onPressed: () {
                        btnEvent(context);
                      },
                      child: const Icon(
                        Icons.bolt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  btnEvent(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              bottom: 80,
              right: 0,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      FlutterBtn(
                          title: 'Save',
                          icn: Icons.download,
                          event: () => showFullScreenDialog(
                                context,
                                rs1.value +
                                    rs2.value +
                                    rs5.value +
                                    rs10.value +
                                    rs20.value +
                                    rs50.value +
                                    rs100.value +
                                    rs200.value +
                                    rs500.value +
                                    rs2000.value,
                                {
                                  "valueCntr_2000":
                                      int.tryParse(rs2000Controller.text) ?? 0,
                                  "valueCntr_500":
                                      int.tryParse(rs500Controller.text) ?? 0,
                                  "valueCntr_200":
                                      int.tryParse(rs200Controller.text) ?? 0,
                                  "valueCntr_100":
                                      int.tryParse(rs100Controller.text) ?? 0,
                                  "valueCntr_50":
                                      int.tryParse(rs50Controller.text) ?? 0,
                                  "valueCntr_20":
                                      int.tryParse(rs20Controller.text) ?? 0,
                                  "valueCntr_10":
                                      int.tryParse(rs10Controller.text) ?? 0,
                                  "valueCntr_5":
                                      int.tryParse(rs5Controller.text) ?? 0,
                                  "valueCntr_2":
                                      int.tryParse(rs2Controller.text) ?? 0,
                                  "valueCntr_1":
                                      int.tryParse(rs5Controller.text) ?? 0,
                                },
                              )),
                      FlutterBtn(
                          title: 'Clear',
                          icn: Icons.autorenew,
                          event: () {
                            rs1.value = 0;
                            rs2.value = 0;
                            rs5.value = 0;
                            rs10.value = 0;
                            rs20.value = 0;
                            rs50.value = 0;
                            rs100.value = 0;
                            rs200.value = 0;
                            rs500.value = 0;
                            rs2000.value = 0;
                            rs2000Controller.clear();
                            rs500Controller.clear();
                            rs200Controller.clear();
                            rs100Controller.clear();
                            rs50Controller.clear();
                            rs20Controller.clear();
                            rs10Controller.clear();
                            rs5Controller.clear();
                            rs2Controller.clear();
                            rs1Controller.clear();
                            titleController.clear();
                            Utils.snackBar('reset'.tr, 'reset_msg'.tr);
                            navigator!.pop();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
