import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../res/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/history_view_models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryController historyController = Get.put(HistoryController());
  final formatCurrency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(.1),
      ),
      body: Obx(
        () {
          final historyData = historyController.userList.value.retrievedData;

          if (historyData == null || historyData.isEmpty) {
            return const Center(
              child: Text(
                'No History Found!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final data = historyData[index];
                final cashData =
                    historyController.userList.value.cashdata?.value2000;
                return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Slidable(
                        key: ValueKey(index),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                historyController.deleteHistory(data.id);
                              },
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              padding: EdgeInsets.zero,
                              spacing: 0,
                            ),
                            SlidableAction(
                              onPressed: (_) {
                                Get.toNamed(RouteName.cashcounter, arguments: [
                                  true,
                                  data.cashvalue?.valueCntr2000 ?? 0,
                                  data.cashvalue?.valueCntr500 ?? 0,
                                  data.cashvalue?.valueCntr200 ?? 0,
                                  data.cashvalue?.valueCntr100 ?? 0,
                                  data.cashvalue?.valueCntr50 ?? 0,
                                  data.cashvalue?.valueCntr20 ?? 0,
                                  data.cashvalue?.valueCntr10 ?? 0,
                                  data.cashvalue?.valueCntr5 ?? 0,
                                  data.cashvalue?.valueCntr2 ?? 0,
                                  data.cashvalue?.valueCntr1 ?? 0,
                                  data.id,
                                  data.name,
                                  data.category
                                ]);
                                Utils.snackBar('Edit', 'You open in edit mode');
                              },
                              backgroundColor: Colors.lightBlueAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              padding: EdgeInsets.zero,
                              spacing: 0,
                            ),
                            SlidableAction(
                              onPressed: (__) {
                                String textToShare = '''
${data.category}
Denomination
${data.date} ${data.time}
Rgg
---------------------------------------
Rupee x Counts = Total
₹ 2000    x ${data.cashvalue?.valueCntr2000 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr2000 ?? 0) * 2000)}
₹ 500    x ${data.cashvalue?.valueCntr500 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr500 ?? 0) * 500)}
₹ 200    x ${data.cashvalue?.valueCntr200 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr200 ?? 0) * 200)}
₹ 100    x ${data.cashvalue?.valueCntr100 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr100 ?? 0) * 100)}
₹ 50    x ${data.cashvalue?.valueCntr50 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr50 ?? 0) * 50)}
₹ 20    x ${data.cashvalue?.valueCntr20 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr20 ?? 0) * 50)}
₹ 10    x ${data.cashvalue?.valueCntr10 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr10 ?? 0) * 50)}
₹ 5    x ${data.cashvalue?.valueCntr5 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr5 ?? 0) * 50)}
₹ 2    x ${data.cashvalue?.valueCntr2 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr2 ?? 0) * 50)}
₹ 5    x ${data.cashvalue?.valueCntr1 ?? 0} = ${formatCurrency.format((data.cashvalue?.valueCntr1 ?? 0) * 50)}
---------------------------------------
Total Counts:
${(data.cashvalue?.valueCntr2000 ?? 0) + (data.cashvalue?.valueCntr500 ?? 0) + (data.cashvalue?.valueCntr200 ?? 0) + (data.cashvalue?.valueCntr100 ?? 0) + (data.cashvalue?.valueCntr50 ?? 0) + (data.cashvalue?.valueCntr20 ?? 0) + (data.cashvalue?.valueCntr10 ?? 0) + (data.cashvalue?.valueCntr5 ?? 0) + (data.cashvalue?.valueCntr2 ?? 0) + (data.cashvalue?.valueCntr1 ?? 0)}
=======
Grand Total Amount:
${formatCurrency.format(data.total)}
${Utils.convertNumberToWords(data.total!.round() ?? 0)}
                                 only/-
''';
                                Share.share(textToShare);
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.share,
                              padding: EdgeInsets.zero,
                              spacing: 0,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.category}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${formatCurrency.format(data.total)}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: data.category == 'General'
                                          ? Colors.blue
                                          : data.category == 'Income'
                                              ? Colors.green
                                              : data.category == 'Expense'
                                                  ? Colors.red
                                                  : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    data.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 162, 209, 245),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.date ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 162, 209, 245),
                                    ),
                                  ),
                                  Text(
                                    data.time ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 162, 209, 245),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )));
              },
            ),
          );
        },
      ),
    );
  }
}
