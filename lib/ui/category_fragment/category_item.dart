import 'package:flutter/material.dart';
import 'package:newsapproute/l10n/app_localizations.dart';
import 'package:newsapproute/models/category.dart';
import 'package:provider/provider.dart';

import '../../providers/app_languages_provider.dart';
import '../../utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;
   CategoryItem({super.key,required this.category,required this.index});

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguagesProvider>(context);
    return Stack(
      alignment: (index%2==0)?Alignment.bottomRight:Alignment.bottomLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(width*0.04),
          child: Image.asset(category.image),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: width*0.04),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(width*0.08),
              color: AppColors.greyColor,
            ),
            child: Row(
              textDirection: ( languageProvider.isEnglish())?
              getTextDirectionEnglish():getTextDirectionArabic(),
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Text(AppLocalizations.of(context)!.view_all,style: Theme.of(context).textTheme.headlineMedium,),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    (index%2==0)?
                    Icons.arrow_forward_ios:
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).indicatorColor,),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  TextDirection getTextDirectionEnglish(){
    if(index%2==0){
      return TextDirection.ltr;
    }
    return TextDirection.rtl;
  }
  TextDirection getTextDirectionArabic(){
    if(index%2==0){
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}
