import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapproute/models/NewsResponse.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../utils/app_colors.dart';

class NewsContainerWidget extends StatelessWidget {
  News news;
   NewsContainerWidget({super.key,required this.news});

  @override
  Widget build(BuildContext context) {
    //Text(newsList[index].title??'',style: Theme.of(context).textTheme.labelMedium,)
    var width=MediaQuery.of(context).size.width;
    String timeAgo='';
    String getTimeAgo(String publishedAt) {
      final publishedDate = DateTime.parse(publishedAt).toLocal();
      return timeago.format(publishedDate);
    }
    // todo:manual date format into minutes function
    // if (news.publishedAt != null) {
    //   try {
    //     final publishedDate = DateTime.parse(news.publishedAt!).toLocal();
    //     final now = DateTime.now();
    //     final difference = now.difference(publishedDate);
    //     final minutes = difference.inMinutes;
    //
    //     timeAgo = '$minutes minutes ago';
    //
    //   } catch (e) {
    //     timeAgo = '';
    //   }
    // }

    return Container(
      padding: EdgeInsets.all(width*0.02),
      margin: EdgeInsets.all(width*0.02),
      decoration: BoxDecoration(
        color: AppColors.transparentColor,
        borderRadius: BorderRadius.circular(width*0.04),
        border: Border.all(
          color: Theme.of(context).indicatorColor,
          width: 1.5,
        )
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(width*0.04),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage??'',
              placeholder: (context, url) => CircularProgressIndicator(
                color: AppColors.greyColor,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Text(news.title??'',style: Theme.of(context).textTheme.labelMedium,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('By:${news.author??''}',style: Theme.of(context).textTheme.labelSmall,)),

              Text(
                getTimeAgo(news.publishedAt!),
                //manual date format into minutes
                //timeAgo
                style: Theme.of(context).textTheme.labelSmall,
              ),

            ],
          )
        ],
      ),
    );
  }
}
