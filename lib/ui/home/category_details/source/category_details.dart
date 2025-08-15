import 'package:flutter/material.dart';
import 'package:newsapproute/api/api_manager.dart';
import 'package:newsapproute/models/SourceResponse.dart';
import 'package:newsapproute/ui/home/category_details/source/sources_tab.dart';
import 'package:newsapproute/utils/app_colors.dart';

import '../../../../models/category.dart';

class CategoryDetails extends StatefulWidget {
  Category category;
   CategoryDetails({super.key,required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(widget.category.id),
        builder: (context, snapshot) {
          //todo: loading phase
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
            );
          }
          //todo: error client phase
          else if(snapshot.hasError){
            return Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something went wrong',style: Theme.of(context).textTheme.labelMedium,),
                    ElevatedButton(onPressed: (){
                      ApiManager.getSources(widget.category.id);
                      setState(() {

                      });
                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyColor
                        ),
                        child: Text('Try again',style: Theme.of(context).textTheme.labelMedium,)
                    )
                  ],
                ),
              ),
            );
          }
          //todo: error server phase
          if(snapshot.data?.status!='ok'){
            return Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.message!,style: Theme.of(context).textTheme.labelMedium,),
                    ElevatedButton(onPressed: (){
                      ApiManager.getSources(widget.category.id);
                      setState(() {

                      });
                    },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyColor
                        ),
                        child: Text('Try again',style: Theme.of(context).textTheme.labelMedium,)
                    )
                  ],
                ),
              ),
            );
          }
          var sourceList=snapshot.data?.sources??[];
          //todo: success server phase
          return SourcesTab(sourceList: sourceList,);
        },
    );
  }
}
