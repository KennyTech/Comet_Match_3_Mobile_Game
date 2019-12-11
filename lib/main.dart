/*
* Program:  Final Mobile Project
* Authors:  Mustafa Al-Azzawe (100617392)
*           Daniyal Shah (100622173)
*           Kenny Le (100616323)
*           Alvin Lum
* Purpose:  Runner Mobile Game
* Submitted on: 2019/12/14
* Submitted to: Randy Fortier
*/

import 'package:flutter/material.dart';

import 'package:finalproject/screen/root_page.dart';
import 'package:finalproject/services/base_auth.dart';

import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Project Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new RootPage(auth: new Auth()),
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'en',
          path: 'assets/i18n',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}