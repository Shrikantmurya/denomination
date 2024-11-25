import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../res/assets/image_assets.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

double rWidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
// ignore: deprecated_member_use
double rHeight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current) {
    current.unfocus();
  }

  //get greating msg
  static getGreetingMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 18) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  static String getddmmyy(data) {
    return DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(data.isEmpty ? '0000-00-00' : data))
        .toString();
  }

  static getCurrentMonth() {
    DateTime now = DateTime.now();
    String currentMonth = DateFormat.MMM().format(now);
    return currentMonth;
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message,
        maxWidth: rWidth * 1,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              ImageAssets.logo,
            ),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        margin: const EdgeInsets.only(bottom: 30),
        backgroundColor: const Color.fromARGB(255, 16, 40, 74),
        borderRadius: 100);
  }

  static openFile(String fileUrl) async {
    if (await canLaunch(fileUrl)) {
      await launch(
        fileUrl,
        forceWebView: true,
      );
    }
  }

  static String convertNumberToWords(int number) {
    if (number == 0) return 'Zero';

    final units = [
      '',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen'
    ];

    final tens = [
      '',
      '',
      'Twenty',
      'Thirty',
      'Forty',
      'Fifty',
      'Sixty',
      'Seventy',
      'Eighty',
      'Ninety'
    ];

    final scales = ['', 'Thousand', 'Lakh', 'Crore'];

    String convertBelowHundred(int number) {
      if (number == 0) return '';
      if (number < 20) return units[number];
      return '${tens[number ~/ 10]} ${units[number % 10]}'.trim();
    }

    String convertBelowThousand(int number) {
      if (number < 100) {
        return convertBelowHundred(number);
      }
      return '${units[number ~/ 100]} Hundred ${convertBelowHundred(number % 100)}'
          .trim();
    }

    List<String> parts = [];
    int scaleIndex = 0;

    while (number > 0) {
      int remainder = number % 1000;
      if (remainder != 0) {
        parts.add(
            '${convertBelowThousand(remainder)} ${scales[scaleIndex]}'.trim());
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return parts.reversed.join(' ').trim();
  }

  static launchEmail(email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'ContactUs',
        'body': '',
      },
    );
    await launchUrl(launchUri);
  }

  static makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
