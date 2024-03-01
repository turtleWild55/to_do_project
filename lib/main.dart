import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_project/firebase_functions/firebase_options.dart';
import 'package:to_do_project/home_screen.dart';
import 'package:to_do_project/login/login_screen.dart';
import 'package:to_do_project/my_theme.dart';
import 'package:to_do_project/providers/app_config_provider.dart';
import 'package:to_do_project/register/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(
          cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
  // The default value is 40 MB. The threshold must be set to at least 1 MB,
// and can be set to Settings.CACHE_SIZE_UNLIMITED to disable garbage collection.


  runApp(ChangeNotifierProvider(
      create:(context)=>AppConfigProvider(),child: MyApp()));

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
provider.getPreflang();

    provider.getPrefTheme();
    return MaterialApp(initialRoute: HomeScreen.routeName,
      routes: {///Login.routeName:(context)=>Login(),
       /// RegisterScreen.routeName:(context)=>RegisterScreen(),
      HomeScreen.routeName:(context)=>HomeScreen()},
    themeMode:provider.appTheme ,

    theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
    localizationsDelegates: AppLocalizations.localizationsDelegates ,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: Locale(provider.lang),);
  }

}

