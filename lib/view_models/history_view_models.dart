import 'dart:convert';

import 'package:get/get.dart';

import '../res/model/history_model.dart';
import '../res/sqldb.dart';
import '../utils/utils.dart';

class HistoryController extends GetxController {
  final userList = HistoryListModel().obs;
  RxString error = ''.obs;
  RxBool loading = false.obs;

  void setUserList(HistoryListModel _value) => userList.value = _value;
  void setError(String _value) => error.value = _value;

  @override
  void onInit() {
    super.onInit();
    historyData();
  }

  Future<void> historyData() async {
    dynamic cashJson;
    final dbHelper = DatabaseHelper.instance;

    final List<Map<String, dynamic>> retrievedData =
        await dbHelper.retrieveData();

    List<Map<String, dynamic>> dataWithParsedCashValue =
        retrievedData.map((data) {
      Map<String, dynamic> mutableData = Map.from(data);

      if (mutableData['cashvalue'] != null &&
          mutableData['cashvalue'] is String) {
        String cashvalueString = mutableData['cashvalue'];

        // Ensure cashvalueString is valid JSON before attempting to decode
        print('Raw cashvalueString: $cashvalueString');

        try {
          // Check if the string is properly formatted before decoding
          var parsedCashValue = jsonDecode(cashvalueString);

          print('Parsed cashvalue: $parsedCashValue');

          mutableData['cashvalue'] = Cashvalue.fromJson(parsedCashValue);
        } catch (e) {
          print('Error decoding cashvalue: $e');
          mutableData['cashvalue'] = null;
        }
      }

      return mutableData;
    }).toList();

    setUserList(
        HistoryListModel.fromJson({"retrievedData": dataWithParsedCashValue}));

    if (userList.value.retrievedData != null &&
        userList.value.retrievedData!.isNotEmpty) {
      var cashvalue = userList.value.retrievedData?[0].cashvalue;
      print(cashvalue);
    } else {
      print('retrievedData is empty or null');
    }
  }

  Future<void> deleteHistory(index) async {
    final dbHelper = DatabaseHelper.instance;

    await dbHelper.deleteData(index);
    historyData();
    Utils.snackBar('Delete', 'Row deleted successfully');
  }
}
