import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  String _formatSharedText(data) {
    final cashValue = data.cashvalue;
    final grandTotal = formatCurrency.format(data.total);
    final totalWords = Utils.convertNumberToWords(data.total!.round());

    String formatRow(int denomination, int? count) {
      if (count == null || count == 0) return '';
      final total = formatCurrency.format(denomination * count);
      return '₹ $denomination x $count = $total\n';
    }

    final rows = [
      formatRow(2000, cashValue?.valueCntr2000),
      formatRow(500, cashValue?.valueCntr500),
      formatRow(200, cashValue?.valueCntr200),
      formatRow(100, cashValue?.valueCntr100),
      formatRow(50, cashValue?.valueCntr50),
      formatRow(20, cashValue?.valueCntr20),
      formatRow(10, cashValue?.valueCntr10),
      formatRow(5, cashValue?.valueCntr5),
      formatRow(2, cashValue?.valueCntr2),
      formatRow(1, cashValue?.valueCntr1),
    ].where((row) => row.isNotEmpty).join();

    return '''
${data.category}
Denomination
${data.date} ${data.time}
---------------------------------------
Rupee x Counts = Total
$rows---------------------------------------
Total Counts: ${_calculateTotalCounts(cashValue)}
=======
Grand Total Amount:
$grandTotal
$totalWords only/-
''';
  }

  int _calculateTotalCounts(cashValue) {
    return (cashValue?.valueCntr2000 ?? 0) +
        (cashValue?.valueCntr500 ?? 0) +
        (cashValue?.valueCntr200 ?? 0) +
        (cashValue?.valueCntr100 ?? 0) +
        (cashValue?.valueCntr50 ?? 0) +
        (cashValue?.valueCntr20 ?? 0) +
        (cashValue?.valueCntr10 ?? 0) +
        (cashValue?.valueCntr5 ?? 0) +
        (cashValue?.valueCntr2 ?? 0) +
        (cashValue?.valueCntr1 ?? 0);
  }

  Widget _buildHistoryItem(data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        key: ValueKey(data.id),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            _buildSlidableAction(
              icon: Icons.delete,
              color: Colors.redAccent,
              label: 'Delete',
              onTap: () => historyController.deleteHistory(data.id),
            ),
            _buildSlidableAction(
              icon: Icons.edit,
              color: Colors.lightBlueAccent,
              label: 'Edit',
              onTap: () {
                Get.toNamed(
                  RouteName.cashcounter,
                  arguments: [
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
                    data.category,
                  ],
                );
                Utils.snackBar('Edit', 'You open in edit mode');
              },
            ),
            _buildSlidableAction(
              icon: Icons.share,
              color: Colors.green,
              label: 'Share',
              onTap: () {
                final textToShare = _formatSharedText(data);
                Share.share(textToShare);
              },
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHistoryDetails(data),
              _buildHistoryDateAndTime(data),
            ],
          ),
        ),
      ),
    );
  }

  SlidableAction _buildSlidableAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return SlidableAction(
      onPressed: (_) => onTap(),
      backgroundColor: color,
      foregroundColor: Colors.white,
      icon: icon,
      label: label,
    );
  }

  Widget _buildHistoryDetails(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.category ?? '',
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          formatCurrency.format(data.total),
          style: TextStyle(
            fontSize: 22,
            color: _getCategoryColor(data.category),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.name ?? '',
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 162, 209, 245),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryDateAndTime(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
    );
  }

  Color _getCategoryColor(String? category) {
    switch (category) {
      case 'General':
        return Colors.blue;
      case 'Income':
        return Colors.green;
      case 'Expense':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

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
                return _buildHistoryItem(data);
              },
            ),
          );
        },
      ),
    );
  }
}
