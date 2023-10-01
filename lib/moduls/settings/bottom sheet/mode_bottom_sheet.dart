import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/moduls/settings/selected_and_unselected/selected_item.dart';
import 'package:todo/moduls/settings/selected_and_unselected/unselected_item.dart';
import 'package:provider/provider.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ModeBottomSheet extends StatelessWidget {
  const ModeBottomSheet({super.key});

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
            provider.enableLightTheme();
          },
          child: provider.isDark()
              ? UnSelectedItem(AppLocalizations.of(context)!.light)
              : SelectedItem(AppLocalizations.of(context)!.light),
        ),
        InkWell(
          onTap: () {
            provider.enableDarkTheme();
          },
          child:
              provider.isDark() ? SelectedItem(AppLocalizations.of(context)!.dark) : UnSelectedItem(AppLocalizations.of(context)!.dark),
        ),
      ]),
    );
  }
}
