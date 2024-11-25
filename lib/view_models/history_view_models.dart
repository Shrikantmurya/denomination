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
    final dbHelper = DatabaseHelper.instance;

    final List<Map<String, dynamic>> retrievedData =
        await dbHelper.retrieveData();

    List<Map<String, dynamic>> dataWithParsedCashValue =
        retrievedData.map((data) {
      Map<String, dynamic> mutableData = Map.from(data);

      if (mutableData['cashvalue'] != null &&
          mutableData['cashvalue'] is String) {
        String cashvalueString = mutableData['cashvalue'];

        print('Raw cashvalueString: $cashvalueString');

        try {
          // Preprocess the string to ensure valid JSON format
          cashvalueString = cashvalueString.replaceAllMapped(
            RegExp(r'(\w+):'),
            (match) => '"${match.group(1)}":',
          );

          print('Processed cashvalueString: $cashvalueString');

          // Parse the corrected JSON string
          var parsedCashValue = jsonDecode(cashvalueString);

          // Map the parsed data to the Cashvalue object
          mutableData['cashvalue'] = parsedCashValue;

          print('Parsed Cashvalue object: ${mutableData['cashvalue']}');
        } catch (e) {
          print('Error decoding cashvalue: $e');
          mutableData['cashvalue'] = null;
        }
      }

      return mutableData;
    }).toList();

    // Update the userList
    setUserList(
        HistoryListModel.fromJson({"retrievedData": dataWithParsedCashValue}));

    // Debug: Check if the userList has valid data
    if (userList.value.retrievedData != null &&
        userList.value.retrievedData!.isNotEmpty) {
      var cashvalue = userList.value.retrievedData![0].cashvalue?.valueCntr500;

      if (cashvalue != null) {
        print('Cashvalue: ${cashvalue}'); // Example field access
      } else {
        print('Cashvalue is null');
      }
    } else {
      print('retrievedData is empty or null');
    }
  }

  Future<void> deleteHistory(index) async {
    final dbHelper = DatabaseHelper.instance;

    final result = await dbHelper.deleteData(index);
    if (result == 1) {
      historyData();
      Utils.snackBar('Delete', 'Row deleted successfully');
    }
  }
}
