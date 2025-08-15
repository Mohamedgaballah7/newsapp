import 'package:flutter/material.dart';
import 'package:newsapproute/models/SourceResponse.dart';
import 'package:newsapproute/ui/home/category_details/news/news_details.dart';
import 'package:newsapproute/ui/home/category_details/source/source_name_tab.dart';
import 'package:newsapproute/utils/app_colors.dart';

class SourcesTab extends StatefulWidget {
  List<Sources>sourceList;

   SourcesTab({super.key,required this.sourceList,});

  @override
  State<SourcesTab> createState() => _SourcesTabState();
}

class _SourcesTabState extends State<SourcesTab> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: widget.sourceList.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index){
                selectedIndex=index;
                setState(() {

                });
              },
              tabAlignment: TabAlignment.start,
              isScrollable: true,
                indicatorColor: Theme.of(context).indicatorColor,
                dividerColor: AppColors.transparentColor,
                tabs: widget.sourceList.map((source) {
                  return SourceNameTab(source: source,isSelected: selectedIndex==widget.sourceList.indexOf(source),);
                },).toList()
            ),

            NewsDetails(
              source:
              widget.sourceList[selectedIndex],),
          ],
        )
    );
  }
}
