import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../res/assets/image_assets.dart';
import '../res/colors/app_color.dart';
import '../res/components/button.dart';
import '../res/components/currencyrow.dart';
import '../res/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../res/sqldb.dart';
import '../utils/utils.dart';
import '../view_models/history_view_models.dart';

class CashCounter extends StatefulWidget {
  const CashCounter({super.key});

  @override
  State<CashCounter> createState() => _CashCounterState();
}

class _CashCounterState extends State<CashCounter> {
  HistoryController history = Get.put(HistoryController());
  var ediData = Get.arguments;

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

  final ThemeController themeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (ediData != null && (ediData[0] ?? false) == true) {
      rs2000Controller.text = ediData[1] == 0 ? '' : ediData[1].toString();
      rs500Controller.text = ediData[2] == 0 ? '' : ediData[2].toString();
      rs200Controller.text = ediData[3] == 0 ? '' : ediData[3].toString();
      rs100Controller.text = ediData[4] == 0 ? '' : ediData[4].toString();
      rs50Controller.text = ediData[5] == 0 ? '' : ediData[5].toString();
      rs20Controller.text = ediData[6] == 0 ? '' : ediData[6].toString();
      rs10Controller.text = ediData[6] == 0 ? '' : ediData[7].toString();
      rs5Controller.text = ediData[8] == 0 ? '' : ediData[8].toString();
      rs2Controller.text = ediData[9] == 0 ? '' : ediData[9].toString();
      rs1Controller.text = ediData[10] == 0 ? '' : ediData[10].toString();

      rs2000.value = 2000 * ediData[1] as int;
      rs2000Note.value = ediData[1] as int;

      rs500.value = 500 * ediData[2] as int;
      rs500Note.value = ediData[2] as int;

      rs200.value = 200 * ediData[3] as int;
      rs200Note.value = ediData[3] as int;

      rs100.value = 100 * ediData[4] as int;
      rs100Note.value = ediData[4] as int;

      rs50.value = 50 * ediData[5] as int;
      rs50Note.value = ediData[5] as int;

      rs20.value = 20 * ediData[6] as int;
      rs20Note.value = ediData[6] as int;

      rs10.value = 10 * ediData[7] as int;
      rs10Note.value = ediData[7] as int;

      rs5.value = 5 * ediData[8] as int;
      rs5Note.value = ediData[8] as int;

      rs2.value = 2 * ediData[9] as int;
      rs2Note.value = ediData[9] as int;

      rs1.value = 1 * ediData[10] as int;
      rs1Note.value = ediData[10] as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Obx(
        () => MaterialApp(
          theme: themeController.lightTheme,
          darkTheme: themeController.darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Scaffold(
            backgroundColor: const Color.fromARGB(255, 41, 41, 41),
            body: Column(
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
                                  child: Text('Total Amount}',
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
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
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
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      onPressed: () {
                        print("Floating Circle Button Pressed");
                      },
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Theme.of(context).primaryColor,
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
                            claer();
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

  TextEditingController remarkController = TextEditingController();
  RxString selectedValue = 'General'.obs;
  Future<void> showFullScreenDialog(
      BuildContext context, total, cashvalue) async {
    Navigator.of(context).pop();

    if (ediData != null && (ediData[0] ?? false) == true) {
      selectedValue.value = ediData[13];
      remarkController.text = ediData[12];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 29, 29),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -10,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 30.0,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 0,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedValue.value,
                        onChanged: (String? newValue) {
                          selectedValue.value = newValue!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 78, 78, 78),
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        items: const [
                          DropdownMenuItem(
                            value: 'General',
                            child: Text(
                              'General',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Income',
                            child: Text(
                              'Income',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Expense',
                            child: Text(
                              'Expense',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: remarkController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 78, 78, 78),
                          hintText: 'Fill your remark(If any)',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 151, 151, 151),
                              fontSize: 13),
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        maxLines: 3,
                        minLines: 3,
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 24, 44, 67),
                                title: Text('Confirmation',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16)),
                                content: const Text('Are you sure?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 'No');
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () async {
                                      try {
                                        String isoDateTime =
                                            DateTime.now().toIso8601String();
                                        DateTime dateTime =
                                            DateTime.parse(isoDateTime);

                                        String formattedDate =
                                            DateFormat('MMM dd, yyyy')
                                                .format(dateTime);
                                        String formattedTime =
                                            DateFormat('h:mm a')
                                                .format(dateTime);

                                        Map<String, dynamic> cashList = {
                                          "name": remarkController.text.isEmpty
                                              ? "Untitled"
                                              : remarkController.text,
                                          "total": total,
                                          "category":
                                              selectedValue.value.toString(),
                                          "date": formattedDate,
                                          "time": formattedTime,
                                          "cashvalue": cashvalue.toString()
                                        };

                                        final dbHelper =
                                            DatabaseHelper.instance;

                                        if (ediData != null &&
                                            (ediData[0] ?? false) == true) {
                                          print(ediData[0]);
                                          final result =
                                              await dbHelper.updateData(
                                                  ediData[11], cashList);
                                          if (result == 1) {
                                            claer();
                                            history.historyData();
                                            Utils.snackBar('Update Successful',
                                                'Your data has been Update.');
                                          }
                                        } else {
                                          final result = await dbHelper
                                              .insertData(cashList);
                                          if (result > 0) {
                                            claer();
                                            history.historyData();
                                            Utils.snackBar('Save Successful',
                                                'Your data has been saved.');
                                          }
                                        }

                                        Navigator.of(context).pop();
                                      } catch (error) {
                                        print(error);
                                        Utils.snackBar('Error',
                                            'Failed to save data: $error');
                                        print(
                                            'Error while saving data: $error');
                                      }
                                      Navigator.pop(context, 'Yes');
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  claer() {
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
    ediData = null;
    remarkController.text = '';
    selectedValue.value = 'General';
  }
}
