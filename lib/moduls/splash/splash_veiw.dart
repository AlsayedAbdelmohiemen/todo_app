import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo/moduls/login/log_in.dart';
import 'package:provider/provider.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
class Splashview extends StatelessWidget {
  const Splashview({super.key});
  static const String routeName = "splash";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
    return Container(
        decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage(!provider.isDark()
                    ? "assets/images/splash_light.png":
                     "assets/images/splash _dark.png"),
                fit: BoxFit.fill)));
  }
}
