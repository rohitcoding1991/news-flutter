import '../../../services/storage/storageServices.dart';
import '../models/articleModel.dart';

abstract class LocalDataSource{
  Future<List<ArticleModel>> getBookMarkList();
  Future addBookMark({required ArticleModel data});
  Future removeBookMark({required ArticleModel data});
}

class LocalDataSourceImpl extends LocalDataSource{
  final StorageService _service;

  LocalDataSourceImpl({required StorageService service}) : _service = service;

  @override
  Future addBookMark({required ArticleModel data}) async{
    return await _service.addArticle(data: data);
  }

  @override
  Future<List<ArticleModel>> getBookMarkList() async{
    return await _service.getArticleList();
  }

  @override
  Future removeBookMark({required ArticleModel data}) async{
    return await _service.removeArticle(data: data);
  }

}