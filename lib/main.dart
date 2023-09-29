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
  final prefs = await SharedPreferences.getInstance();
  String theme = prefs.getString('theme') ?? 'light';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()
            ..changeLocale(prefs.getString('language') ?? 'en'),
        ),
        ChangeNotifierProvider(
            create: (_) => ThemingProvider()
              ..changeTheme(
                  theme == 'light' ? MyTheme.lightMode : MyTheme.darkMode)),
        ChangeNotifierProvider(create: (_) => TodosProvider()),
      ],
      child: const Todo(),
    ),
  );
  FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    ThemingProvider themingProvider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: Locale(languageProvider.appLocale),
      home: const HomeScreen(),
      theme: themingProvider.appTheme.copyWith(useMaterial3: true),
      darkTheme: MyTheme.darkMode,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        EditTask.routeName: (_) => const EditTask()
      },
    );
  }
}
