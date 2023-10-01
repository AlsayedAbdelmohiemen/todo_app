import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/moduls/signup/signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(!provider.isDark()
                  ? "assets/images/sign_in_background.png"
                  : "assets/images/login_and_singup_dark.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return " Please enter username";
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.username),
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return " Please enter Password ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label:Text(AppLocalizations.of(context)!.password) ,
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: MyTheme.lightPrimary)),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunctions.login(
                                emailController.text, passwordController.text)
                            .then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeLayout.routeName, (route) => false);
                        }).catchError((e) {
                          print(e);
                        });
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.login)),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.auth),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(AppLocalizations.of(context)!.createaccount))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
