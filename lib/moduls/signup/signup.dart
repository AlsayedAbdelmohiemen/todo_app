import 'package:flutter/material.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/moduls/login/log_in.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignUpScreen extends StatelessWidget {
  static const String routeName = "signUp";
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(!provider.isDark()
                  ? "assets/images/signup_background.png"
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
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == "") {
                      return " Please enter name";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    label:  Text(AppLocalizations.of(context)!.name),
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
                TextFormField(
                  controller: ageController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value == "") {
                      return " Please enter age";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.age),
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
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
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
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 5) {
                      return " Please enter Password ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.password),
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
                        FirebaseFunctions.signUp(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                                int.parse(ageController.text))
                            .then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (route) => false);
                        }).catchError((e) {
                          print(e);
                        });
                      }
                    },
                    child: const Text("Sign Up")),
                Row(
                  children: [
                    const Text("I have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (route) => false);
                        },
                        child:  Text(AppLocalizations.of(context)!.login))
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
