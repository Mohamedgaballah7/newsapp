import 'package:flutter/material.dart';
import 'package:newsapproute/l10n/app_localizations.dart';
import 'package:newsapproute/models/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsDetailsBottomSheet extends StatefulWidget {
  News news;
   NewsDetailsBottomSheet({super.key,required this.news});

  @override
  State<NewsDetailsBottomSheet> createState() => _NewsDetailsBottomSheetState();
}

class _NewsDetailsBottomSheetState extends State<NewsDetailsBottomSheet> {

  @override
  Widget build(BuildContext context) {
    final Uri newsUrl = Uri.parse(widget.news.url??'');
    var width=MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: width*0.05,horizontal: width*0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(width*0.04),
            child: Image.network(widget.news.urlToImage??''),
          ),
          Text(widget.news.title??'',
              style: Theme.of(context).textTheme.labelMedium!
              .copyWith(color: Theme.of(context).primaryColor)),
          ElevatedButton(
              onPressed: ()async{
                if (await canLaunchUrl(newsUrl)) {
                await launchUrl(newsUrl,mode: LaunchMode.externalApplication,);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(width*0.03))
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: width*0.05),
                child: Text(AppLocalizations.of(context)!.view_all,style: Theme.of(context).textTheme.labelLarge),
              )
          )
        ],
      ),
    );
  }

}
