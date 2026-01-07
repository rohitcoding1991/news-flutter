import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';

import '../entities/articleEntity.dart';
import '../repository/articleRepository.dart';

class GetHeadLinesUseCase extends UseCase<List<ArticleEntity>, NoParams>{
  final ArticleRepository _repo;

  GetHeadLinesUseCase({required ArticleRepository repo}) : _repo = repo;

  @override
  Future<Either<String, List<ArticleEntity>>> call(NoParams params) async{
    return await _repo.getHeadlines();
  }
}