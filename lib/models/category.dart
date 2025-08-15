import 'package:flutter/cupertino.dart';
import 'package:newsapproute/l10n/app_localizations.dart';
import 'package:newsapproute/utils/app_assets.dart';

class Category{
  String id;
  String title;
  String image;
  Category({required this.id,required this.title,required this.image});

  static List<Category> getCategoryModel(bool isDark,BuildContext context){
    return[
      Category(
          id: 'general',
          title: AppLocalizations.of(context)!.general,
          image: isDark?AppAssets.generalCategory:AppAssets.generalCategoryDark
      ),
      Category(
          id: 'business',
          title: AppLocalizations.of(context)!.business,
          image: isDark?AppAssets.businessCategory:AppAssets.businessCategoryDark
      ),
      Category(
          id: 'sports',
          title: AppLocalizations.of(context)!.sports,
          image: isDark?AppAssets.sportCategory:AppAssets.sportCategoryDark
      ),
      Category(
          id: 'health',
          title: AppLocalizations.of(context)!.health,
          image: isDark?AppAssets.healthCategory:AppAssets.healthCategoryDark
      ),
      Category(
          id: 'science',
          title: AppLocalizations.of(context)!.science,
          image: isDark?AppAssets.scienceCategory:AppAssets.scienceCategoryDark
      ),
      Category(
          id: 'technology',
          title: AppLocalizations.of(context)!.technology,
          image: isDark?AppAssets.technologyCategory:AppAssets.technologyCategoryDark
      ),
      Category(
          id: 'entertainment',
          title: AppLocalizations.of(context)!.entertainment,
          image: isDark?AppAssets.entertainmentCategory:AppAssets.entertainmentCategoryDark
      ),
    ];
  }
}