import 'package:flutter/material.dart';
import 'package:mvvm_demo/app/app_prefs.dart';
import 'package:mvvm_demo/app/di.dart';
import 'package:mvvm_demo/core/route/route_manager.dart';
import 'package:mvvm_demo/core/theme/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //private named constructor

  static const MyApp myInstance = MyApp._internal();

  factory MyApp() => myInstance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    // _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
