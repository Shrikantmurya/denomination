import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlutterBtn extends StatefulWidget {
  final String title;
  final IconData icn;
  final Function event;
  const FlutterBtn({
    super.key,
    required this.title,
    required this.icn,
    required this.event,
  });

  @override
  State<FlutterBtn> createState() => _FlutterBtnState();
}

class _FlutterBtnState extends State<FlutterBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () => widget.event(),
        child: Row(
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(250, 97, 97, 97),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color.fromARGB(250, 97, 97, 97),
              ),
              child: Center(
                child: Icon(
                  widget.icn,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
