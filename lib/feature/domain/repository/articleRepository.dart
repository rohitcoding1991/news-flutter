import 'package:dartz/dartz.dart';

import '../entities/articleEntity.dart';

abstract class ArticleRepository {
  Future<Either<String, List<ArticleEntity>>> getHeadlines();

  Future<Either<String, List<ArticleEntity>>> getBookMarks();

  Future<Either<String, bool>> addBookMark({required ArticleEntity data});

  Future<Either<String, bool>> removeBookMark({required ArticleEntity data});
}
