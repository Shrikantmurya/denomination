import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CurrencyRow extends StatefulWidget {
  final TextEditingController controller;

  final String label;
  final ValueChanged<String> onChanged;
  final RxInt result;

  const CurrencyRow({
    super.key,
    required this.label,
    required this.onChanged,
    required this.result,
    required this.controller,
  });

  @override
  State<CurrencyRow> createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  final formatCurrency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  RxBool hasText = false.obs;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      hasText.value = widget.controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: 110,
                  height: 50,
                  child: TextFormField(
                    controller: widget.controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 185, 185, 185),
                        ),
                      ),
                      suffixIcon: hasText.value
                          ? IconButton(
                              icon:
                                  const Icon(Icons.cancel, color: Colors.grey),
                              iconSize: 15,
                              onPressed: () {
                                widget.controller.clear();
                                widget.onChanged('');
                                hasText.value = false;
                              },
                            )
                          : null,
                    ),
                    onChanged: widget.onChanged,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text(
                '=',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Obx(
            () => Text(
              formatCurrency
                  .format(int.parse(widget.result.value.toString()))
                  .split('.')[0],
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
