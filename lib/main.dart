import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart'; // Add this line
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_misc/pages/home_page.dart';

import 'pages/file_log_page.dart'; // Add this line

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /**
     * appState provider 설정
     * 
     * 다국어지원
     https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

     다국어 사용하기.
     AppLocalizations.of(context)!.hello
     */

    return MaterialApp(
      title: 'Flutter Demo',
	  //다국어
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate, // Add this line
          GlobalWidgetsLocalizations.delegate, // Add this line
          GlobalCupertinoLocalizations.delegate, // Add this line
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ko'),
        ],

      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

