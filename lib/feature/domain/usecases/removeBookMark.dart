import 'package:dartz/dartz.dart';
import 'package:news_flutter/core/usecase/usecase.dart';
import 'package:news_flutter/feature/domain/entities/articleEntity.dart';
import 'package:news_flutter/feature/domain/repository/articleRepository.dart';

class RemoveBookMarkUseCase extends UseCase<bool,ArticleEntity>{
  final ArticleRepository _repo;

  RemoveBookMarkUseCase({required ArticleRepository repo}) : _repo = repo;
  @override
  Future<Either<String, bool>> call(ArticleEntity data) async{
    return await _repo.removeBookMark(data: data);
  }

}