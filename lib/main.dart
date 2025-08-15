

import 'package:flutter/material.dart';
import 'package:newsapproute/providers/app_languages_provider.dart';
import 'package:newsapproute/providers/app_theme_provider.dart';
import 'package:newsapproute/ui/category_fragment/category_fragment.dart';
import 'package:newsapproute/ui/home/homescreen.dart';
import 'package:newsapproute/ui/search_news/search_news.dart';
import 'package:newsapproute/utils/app_routes.dart';
import 'package:newsapproute/utils/app_theme.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main(){

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppLanguagesProvider() ),
          ChangeNotifierProvider(create: (context) => AppThemeProvider() ),
        ],
          child: MyApp()));
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    var themeProvider=Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName:(context)=>Homescreen(),
        AppRoutes.searchNewsRouteName:(context)=>SearchNews(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

}
