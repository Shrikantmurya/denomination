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

        cashvalueString = cashvalueString.replaceAllMapped(
            RegExp(r'(\w+):'), (match) => '"${match.group(1)}":');

        try {
          mutableData['cashvalue'] = jsonDecode(cashvalueString);
          cashJson = jsonDecode(cashvalueString);
        } catch (e) {
          print('Error decoding cashvalue: $e');

          mutableData['cashvalue'] = null;
        }
      }

      return mutableData;
    }).toList();

    setUserList(HistoryListModel.fromJson(
        {"retrievedData": dataWithParsedCashValue, "cashdata": cashJson}));

    print(dataWithParsedCashValue);
    print('rani ${userList.value.cashdata?.value500?[0]}');
  }

  Future<void> deleteHistory(index) async {
    final dbHelper = DatabaseHelper.instance;

    await dbHelper.deleteData(index);
    historyData();
    Utils.snackBar('Delete', 'Row deleted successfully');
  }
}
