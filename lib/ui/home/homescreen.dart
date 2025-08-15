import 'package:flutter/material.dart';
import 'package:newsapproute/ui/category_fragment/category_fragment.dart';
import 'package:newsapproute/ui/home/category_details/news/news_details.dart';
import 'package:newsapproute/ui/home/category_details/source/category_details.dart';
import 'package:newsapproute/utils/app_routes.dart';

import '../../l10n/app_localizations.dart';
import '../../models/category.dart';
import '../../utils/app_styles.dart';
import '../search_news/search_news.dart';
import 'drawer/custom_drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return  Scaffold(
      drawer: Drawer(
        width: width*0.7,
        backgroundColor: Theme.of(context).primaryColor,
        child: CustomDrawer(onClickGoHome: onClickGoHome,)

      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          IconButton(onPressed: (){
            // todo: search by title
            Navigator.of(context).pushNamed(AppRoutes.searchNewsRouteName);
          }, icon: Icon(Icons.search,color: Theme.of(context).indicatorColor,)
          )
        ],
        title: Text(selectedCategory==null?AppLocalizations.of(context)!.home:
        selectedCategory!.title,style: Theme.of(context).textTheme.labelLarge,),
      ),
      body: selectedCategory==null?CategoryFragment(onClickCategoryFragment: onClickCategoryFragment):
          CategoryDetails(category: selectedCategory!,)
    );
  }
  Category? selectedCategory;
  void onClickCategoryFragment(Category newCategorySelected) {
    selectedCategory=newCategorySelected;
    setState(() {

    });
  }

  void onClickGoHome() {
    selectedCategory=null;
    Navigator.of(context).pop();
    setState(() {

    });
  }
}
