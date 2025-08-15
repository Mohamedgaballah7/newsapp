
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../providers/app_languages_provider.dart';


class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.03,horizontal: width*0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              languageProvider.changeLanguage('en');
              Navigator.of(context).pop();
            },
            child:languageProvider.appLanguage=='en'?getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english):
          getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english)),
          SizedBox(height: height*0.02,),
          InkWell(
              onTap: (){
                languageProvider.changeLanguage('ar');
                Navigator.of(context).pop();
              },
              child: languageProvider.appLanguage=='ar'?getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic):
              getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic)),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textLanguage}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textLanguage,style: Theme.of(context).textTheme.labelLarge),
        Icon(Icons.check,size: 35,color: Theme.of(context).indicatorColor,)
      ],
    );
  }
  Widget getUnSelectedLanguageItem({required String textLanguage}){
    return Row(
      children: [
        Text(textLanguage,style: Theme.of(context).textTheme.labelMedium,),
      ],
    );
  }
}
