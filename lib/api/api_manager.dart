import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapproute/api/api_constants.dart';
import 'package:newsapproute/api/end_point.dart';
import 'package:newsapproute/models/NewsResponse.dart';
import 'package:newsapproute/models/SourceResponse.dart';

/*https://newsapi.org/v2/top-headlines/sources?apiKey=46708b0a609a4a938b230e2ba4dd2805
* https://newsapi.org/v2/everything?q=bitcoin&apiKey=46708b0a609a4a938b230e2ba4dd2805*/
class ApiManager {
  static Future<SourceResponse> getSources(String categoryId)async{
    var url = Uri.https(
        ApiConstants.baseUrl,
        EndPoint.sourceApi,{
          'apiKey' : ApiConstants.apiKey,
          'category' : categoryId
    });
    try{
      var response=await http.get(url);
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    }
    catch(e){
      throw e;
    }

  }
  static Future<NewsResponse> getNewsBySourceId(String sourceId,String pageNumber)async{
    var url = Uri.https(
        ApiConstants.baseUrl,
        EndPoint.newsApi,{
      'apiKey' : ApiConstants.apiKey,
      'sources' : sourceId,
      'page' : pageNumber
    });
    try{
      var response=await http.get(url);
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }
    catch(e){
      throw e;
    }

  }
  static Future<NewsResponse> getNewsBySearchTitle(String search)async{
    var url = Uri.https(
        ApiConstants.baseUrl,
        EndPoint.newsApi,{
      'apiKey' : ApiConstants.apiKey,
      'q': search,
    });
    try{
      var response=await http.get(url);
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }
    catch(e){
      throw e;
    }

  }
}