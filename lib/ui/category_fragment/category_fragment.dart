import 'package:flutter/material.dart';
import 'package:newsapproute/models/category.dart';
import 'package:newsapproute/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/app_theme_provider.dart';
import '../home/drawer/custom_drawer.dart';
import 'category_item.dart';
typedef OnClickCategoryFragment=void Function(Category);
class CategoryFragment extends StatefulWidget {
OnClickCategoryFragment onClickCategoryFragment;
   CategoryFragment({super.key,required this.onClickCategoryFragment});

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
List<Category>categoriesList=[];

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var themeProvider=Provider.of<AppThemeProvider>(context);

    categoriesList=Category.getCategoryModel(false, context);

    return categoriesList.isEmpty?
    Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.greyColor,))):
    Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.good_morning,style: Theme.of(context).textTheme.headlineMedium,),
              Text(AppLocalizations.of(context)!.some_news,style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(height: height*0.02,),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          widget.onClickCategoryFragment(categoriesList[index]);
                        },
                          child: CategoryItem(category: categoriesList[index],index: index,));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height*0.02,);
                    },
                    itemCount: categoriesList.length
                ),
              ),
            ],
          ),
        )
    );
  }
}
