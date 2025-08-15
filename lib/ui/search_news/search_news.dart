import 'package:flutter/material.dart';
import 'package:newsapproute/l10n/app_localizations.dart';
import '../../api/api_manager.dart';
import '../../models/NewsResponse.dart';
import '../../utils/app_colors.dart';
import '../home/category_details/news/news_container_widget.dart';


class SearchNews extends StatefulWidget {
    SearchNews({super.key});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}
class _SearchNewsState extends State<SearchNews> {
  String newSearchText='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiManager.getNewsBySearchTitle(newSearchText);
  }
  @override

  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*0.03),
          child: Column(
            children: [
              TextField(
                style: Theme.of(context).textTheme.labelMedium,
                cursorColor: Theme.of(context).indicatorColor,
                onChanged: (newText){
                  // todo:searchByNewText(newText);
                  newSearchText=newText;
                  setState(() {

                  });
                  ApiManager.getNewsBySearchTitle(newSearchText);
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  prefixIcon: Icon(Icons.search,
                    color:Theme.of(context).indicatorColor,),
                  suffixIcon: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon:Icon(
                    Icons.cancel_outlined,
                    color:Theme.of(context).indicatorColor,)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Theme.of(context).indicatorColor,
                          width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(color: Theme.of(context).indicatorColor,
                          width: 2)
                  ),
                ),
              ),
           FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySearchTitle(newSearchText),
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
    ApiManager.getNewsBySearchTitle(newSearchText);
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
    return Expanded(
        child: Center(
            child: Text('search News is Empty',style: Theme.of(context).textTheme.headlineLarge,)));
    }
    var newsList=snapshot.data?.articles??[];
    //todo: success server phase
    return Expanded(
    child: ListView.separated(
    itemBuilder: (context, index) {
    return NewsContainerWidget(news: newsList[index],);

    },
    separatorBuilder:(context, index) {
    return SizedBox(height: height*0.01,);
    },
    itemCount: newsList.length
    ),
    );
    },
    )
            ],
          ),
        ),
      ),
    );
  }
}
