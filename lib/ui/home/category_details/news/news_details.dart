import 'package:flutter/material.dart';
import 'package:newsapproute/models/NewsResponse.dart';
import '../../../../api/api_manager.dart';
import '../../../../models/SourceResponse.dart';
import '../../../../utils/app_colors.dart';
import 'news_container_widget.dart';
import 'news_details_bottom_sheet.dart';

class NewsDetails extends StatefulWidget {
  Sources source;
   NewsDetails({super.key,required this.source});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final scrollController=ScrollController();
  int scrollIndex=1;
  late List<News>newList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(widget.source.id??'', scrollIndex.toString()),
      builder: (context, snapshot) {
        //todo: loading phase
        if(snapshot.connectionState==ConnectionState.waiting){
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
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
                    ApiManager.getNewsBySourceId(widget.source.id??'',scrollIndex.toString());
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
                    ApiManager.getNewsBySourceId(widget.source.id??'',scrollIndex.toString());
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
        var newsList=snapshot.data?.articles??[];
        newList=newsList;
        //todo: success server phase
        return Expanded(
          child: ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      showNewsBottomSheet(context, index);
                    },
                    child: NewsContainerWidget(news: newsList[index],));

              },
              separatorBuilder:(context, index) {
                return SizedBox(height: height*0.01,);
              },
              itemCount: newsList.length
          ),
        );
      },
    );
  }

  void showNewsBottomSheet(BuildContext context,int index){
    showModalBottomSheet(
      backgroundColor: Theme.of(context).indicatorColor,
      context: context,
      builder: (context) => NewsDetailsBottomSheet(news: newList[index],),);
  }
void scrollListener(){
  if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
    int newScrollIndex=scrollIndex++;
    ApiManager.getNewsBySourceId(
        widget.source.id ?? '', newScrollIndex.toString());
    setState(() {

    });

  }
      ApiManager.getNewsBySourceId(widget.source.id??'',scrollIndex.toString());
}
}
