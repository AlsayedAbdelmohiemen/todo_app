import 'package:flutter/material.dart';
import 'package:todo/core/network/firebase/firebase_functions.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/moduls/login/log_in.dart';
import 'package:todo/moduls/settings/bottom%20sheet/language_bottom_sheet.dart';
import 'package:todo/moduls/settings/bottom%20sheet/mode_bottom_sheet.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.currentLanguage == "ar"
                          ? AppLocalizations.of(context)!.arabic
                          : AppLocalizations.of(context)!.english,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    Icon(Icons.arrow_drop_down_sharp,
                        color: MyTheme.lightTheme.primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MyTheme.lightTheme.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isDark()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: MyTheme.lightTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 100,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseFunctions.logout().then((_) {
                        // Navigate to the login screen or any other desired screen after logout.
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (Route<dynamic> route) => false,
                        );
                      }).catchError((error) {
                        print("Error during logout: $error");
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.logout),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModeBottomSheet(),
    );
  }
}
