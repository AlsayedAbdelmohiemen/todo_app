import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/style/theme_style.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/moduls/login/log_in.dart';
import 'package:todo/moduls/settings/settings_provider/settings_provider.dart';
import 'package:todo/moduls/signup/signup.dart';
import 'package:todo/moduls/splash/splash_veiw.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      themeMode: provider.themeMode,
      darkTheme: MyTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentLanguage),
      initialRoute: Splashview
          .routeName,


      routes: {
        Splashview.routeName: (context) => const Splashview(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
      },
    );
  }
}
