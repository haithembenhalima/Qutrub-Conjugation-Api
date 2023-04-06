import 'package:flutter/material.dart';
import 'package:qutrub_conjugation_api/Home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qutrub Conjugation API',
      theme: ThemeData(
        fontFamily: 'ReadexPro',
        useMaterial3: true,
      ),
      home: const HomePage(),
      // Arabic language rtl
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE")],
      locale: Locale("ar", "AE"),
    );
  }
}
