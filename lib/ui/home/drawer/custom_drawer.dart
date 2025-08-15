import 'package:flutter/material.dart';
import 'package:newsapproute/l10n/app_localizations.dart';
import 'package:newsapproute/ui/home/drawer/theme/theme_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_languages_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_styles.dart';
import 'language/languages_bottom_sheet.dart';
typedef OnClickGoHome =void Function();
class CustomDrawer extends StatefulWidget {
  OnClickGoHome onClickGoHome;
   CustomDrawer({super.key,required this.onClickGoHome});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<AppThemeProvider>(context);
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: height*0.3,
          width: double.infinity,
          color: Theme.of(context).indicatorColor,
          child: Center(
              child: Text('News App',
                style: AppStyles.bold20White
                    .copyWith(
                    color: Theme.of(context).primaryColor),)),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.01),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  widget.onClickGoHome();
                },
                child: Row(
                  children: [
                    Icon(Icons.home_outlined,color: Theme.of(context).indicatorColor,),
                    SizedBox(width: width*0.01,),
                    Text(AppLocalizations.of(context)!.go_to_home,style: Theme.of(context).textTheme.labelLarge,)
                  ],
                ),
              ),
              SizedBox(height: height*0.01,),
              Divider(
                color: Theme.of(context).indicatorColor,
                thickness: 2,

              ),
              SizedBox(height: height*0.01,),
              customThemeAndLanguageDrawer(
                icon: Icons.format_paint_outlined,
                title: AppLocalizations.of(context)!.theme,
                  content:themeProvider.appTheme==ThemeMode.dark?
                  AppLocalizations.of(context)!.dark:
                  AppLocalizations.of(context)!.light,
                  onTab: (){
                    showThemeBottomSheet();
                    setState(() {

                    });
                  },
                  context: context,
                  height: height,
                  width: width),
              SizedBox(height: height*0.01,),
              Divider(
                color: Theme.of(context).indicatorColor,
                thickness: 2,

              ),
              SizedBox(height: height*0.01,),
              customThemeAndLanguageDrawer(
                  icon: Icons.language,
                  title: AppLocalizations.of(context)!.language,
                  content: languageProvider.appLanguage=='en'?
                  AppLocalizations.of(context)!.english:
                  AppLocalizations.of(context)!.arabic,
                  onTab: (){
                    showLanguageBottomSheet();
                    setState(() {

                    });
                  },
                  context: context,
                  height: height,
                  width: width),
            ],
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }

  Widget customThemeAndLanguageDrawer({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
    required void Function()? onTab,
    required double height,
    required double width
  }){
    return Column(
      children: [
        Row(
          children: [
            Icon(icon,color: Theme.of(context).indicatorColor,),
            SizedBox(width: width*0.01,),
            Text(title,style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
    SizedBox(height: height*0.01,),
    Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(width*0.035),
    border: Border.all(width: width*0.005,color: Theme.of(context).indicatorColor),
    ),
    child: Padding(
    padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.028),
    child: InkWell(
    onTap: onTab,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(content,style: Theme.of(context).textTheme.labelLarge),
    Icon(Icons.arrow_drop_down_sharp,color: Theme.of(context).indicatorColor,size: 35,)
    ],),
    ),
    ),
    )
      ],
    );
  }
}
