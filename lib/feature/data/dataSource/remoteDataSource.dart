import 'dart:convert';


import '../../../services/api/apiServices.dart';
import '../models/articleModel.dart';

abstract class RemoteDataSource{
  Future<List<ArticleModel>> getHeadlines();
}

class RemoteDataSourceImpl extends RemoteDataSource{
  final ApiServices _services;

  RemoteDataSourceImpl({required ApiServices services}) : _services = services;

  @override
  Future<List<ArticleModel>> getHeadlines() async{
    try{
      final response = await _services.getHeadlines();
      final map = jsonDecode(response.bodyString) as Map<String,dynamic>;
      if(response.isSuccessful){
        if(map['status'] == 'ok'){
          return List<ArticleModel>.from(map['articles'].map((json)=> ArticleModel.fromJson(json)));
        }else{
          throw Exception(map.toString());
        }
      }else{
        if(map['status'] == 'error'){
          throw Exception(map['message']);
        }else{
          throw Exception(map.toString());
        }
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

}