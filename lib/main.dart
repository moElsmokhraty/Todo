import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/UI/Home/edit_task_screen.dart';
import 'package:todo/UI/Home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => ThemingProvider()),
    ChangeNotifierProvider(create: (_) => ListProvider()),
  ], child: MyApp()));
  FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late LanguageProvider languageProvider;

  late ThemingProvider themingProvider;

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    themingProvider = Provider.of(context);
    initSharedPreferences();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      locale: Locale(languageProvider.appLocale),
      home: const HomeScreen(),
      theme: themingProvider.appTheme,
      darkTheme: MyTheme.darkMode,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        EditTask.routeName: (_) => const EditTask()
      },
    );
  }

  void initSharedPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    languageProvider.changeLocale(prefs.getString('language') ?? 'en');
    if(prefs.getString('theme') == 'light'){
      themingProvider.changeTheme(MyTheme.lightMode);
    } else if(prefs.getString('theme') == 'dark'){
      themingProvider.changeTheme(MyTheme.darkMode);
    }
  }
}