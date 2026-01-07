import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../feature/data/models/articleModel.dart';

class StorageService {
  static  Box<ArticleModel>? _articleBox;

  Future? create() async {
    await _createBox();
    return;
  }

  Future<void> _createBox()async{
    if(_articleBox == null){
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      Hive.registerAdapter<ArticleModel>(ArticleModelAdapter());
      _articleBox ??= await Hive.openBox<ArticleModel>('article');
    }
    return;
  }

  Future<bool?> addArticle({required ArticleModel data}) async {
    try {
      await _createBox();
       await _articleBox!.add(data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ArticleModel>> getArticleList() async{
    try {
      await _createBox();
      final list = _articleBox!.values.toList();
      list.sort(
            (a, b) => b.publishedAt!.compareTo(a.publishedAt!),);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateArticle({required ArticleModel data}) async {
    try {
      await _createBox();
      final index = await _getKeyByCreatedAt(data.publishedAt!);
      if(index != null){
        await _articleBox!.putAt(index, data);
      }
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeArticle({required ArticleModel data}) async {
    try {
      await _createBox();
      final index = await _getKeyByCreatedAt(data.publishedAt!);
      if(index != null){
        await _articleBox!.deleteAt(index);
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> _getKeyByCreatedAt(DateTime publishedAt) async {
    for (var i = 0; i < _articleBox!.length; i++) {
      final article = _articleBox!.getAt(i);
      if (article != null && article.publishedAt!.isAtSameMomentAs(publishedAt)) {
        return i;
      }
    }
    return null;
  }
}