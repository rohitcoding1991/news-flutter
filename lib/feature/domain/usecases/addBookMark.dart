import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../entities/articleEntity.dart';
import '../repository/articleRepository.dart';

class AddBookMarkUseCase extends UseCase<bool,ArticleEntity>{
  final ArticleRepository _source;

  AddBookMarkUseCase({required ArticleRepository source}) : _source = source;

  @override
  Future<Either<String, bool>> call(ArticleEntity params) async{
   return await _source.addBookMark(data: params);
  }
}