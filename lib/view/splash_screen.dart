import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/assets/image_assets.dart';
import '../res/colors/app_color.dart';
import '../res/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerLogo;
  late Animation<double> _animationLogo;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.toNamed(RouteName.cashcounter));
    _controllerLogo =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationLogo = Tween<double>(
      begin: 200,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controllerLogo,
        curve: Curves.ease,
      ),
    );
    _controllerLogo.forward();
    //animationColor
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controllerLogo,
      builder: (BuildContext context, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
              child:
                  Image.asset(ImageAssets.logo, width: _animationLogo.value)),
        );
      },
    );
  }

  @override
  void dispose() {
    _controllerLogo.dispose();
    super.dispose();
  }
}
