import 'package:flutter/material.dart';
import 'package:todo/moduls/settings/selected_and_unselected/selected_item.dart';
import 'package:todo/moduls/settings/selected_and_unselected/unselected_item.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
          onTap: () {
            provider.selectArabicLanguage();
          },
          child: provider.currentLanguage == "ar"
              ? SelectedItem(AppLocalizations.of(context)!.arabic)
              : UnSelectedItem(AppLocalizations.of(context)!.arabic),
        ),
        InkWell(
          onTap: () {
            provider.selectEnglishLanguage();
          },
          child: provider.currentLanguage == "en"
              ? SelectedItem(AppLocalizations.of(context)!.english)
              : UnSelectedItem(AppLocalizations.of(context)!.english),
        ),
      ]),
    );
  }
}
