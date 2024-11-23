import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../res/sqldb.dart';
import '../utils/utils.dart';

Future<void> showFullScreenDialog(
    BuildContext context, total, cashvalue) async {
  // final path = join(await getDatabasesPath(), 'app_database.db');
  // await deleteDatabase(path);

  Navigator.of(context).pop();

  RxString selectedValue = 'General'.obs;
  TextEditingController remarkController = TextEditingController();
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
                              backgroundColor: Color.fromARGB(255, 24, 44, 67),
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
                                          DateFormat('h:mm a').format(dateTime);

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

                                      final dbHelper = DatabaseHelper.instance;
                                      await dbHelper.insertData(cashList);

                                      Navigator.of(context).pop();

                                      Utils.snackBar('Save Successful',
                                          'Your data has been saved.');
                                    } catch (error) {
                                      print(error);
                                      Utils.snackBar('Error',
                                          'Failed to save data: $error');
                                      print('Error while saving data: $error');
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
