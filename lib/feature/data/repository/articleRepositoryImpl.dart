import 'package:dartz/dartz.dart';
import '../../domain/entities/articleEntity.dart';
import '../../domain/repository/articleRepository.dart';
import '../dataSource/localDataSource.dart';
import '../dataSource/remoteDataSource.dart';

class ArticleRepositoryImpl extends ArticleRepository{
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  ArticleRepositoryImpl({required RemoteDataSource remoteDataSource, required LocalDataSource localDataSource}) : _remoteDataSource = remoteDataSource, _localDataSource = localDataSource;


  @override
  Future<Either<String, List<ArticleEntity>>> getHeadlines() async{
    try{
      final result = await _remoteDataSource.getHeadlines();
      return Right(_modelToEntityList(result));
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> addBookMark({required ArticleEntity data}) async{
    try{
      final result = await _localDataSource.addBookMark(data: data.model);
      return Right(result);
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ArticleEntity>>> getBookMarks() async{
    try{
      final result = await _localDataSource.getBookMarkList();
      return Right(_modelToEntityList(result));
    }catch(e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> removeBookMark({required ArticleEntity data}) async{
    try{
      final result = await _localDataSource.removeBookMark(data: data.model);
      return Right(result);
    }catch(e){
      return Left(e.toString());
    }
  }

  List<ArticleEntity> _modelToEntityList(List data) => List<ArticleEntity>.from(data.map((e) => e.toEntity()));
}