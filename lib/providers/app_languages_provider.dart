
import 'package:flutter/material.dart';

class AppLanguagesProvider extends ChangeNotifier{
  String appLanguage='en';
  void changeLanguage(String newLanguage){
    if(appLanguage==newLanguage){
      return;
    }
    appLanguage=newLanguage;
    notifyListeners();
  }
  bool isEnglish(){
    return appLanguage=='en';
  }
}

