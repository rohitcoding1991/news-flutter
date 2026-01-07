import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'feature/data/dataSource/localDataSource.dart';
import 'feature/data/dataSource/remoteDataSource.dart';
import 'feature/data/repository/articleRepositoryImpl.dart';
import 'feature/domain/usecases/addBookMark.dart';
import 'feature/domain/usecases/getBookMarks.dart';
import 'feature/domain/usecases/getHeadlines.dart';
import 'feature/domain/usecases/removeBookMark.dart';
import 'feature/presentation/block/news_bloc.dart';
import 'feature/presentation/pages/splashView.dart';
import 'services/api/apiServices.dart';
import 'services/storage/storageServices.dart';

void main() async{
  await StorageService().create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final apiService = ApiServices.create();
    final storageService = StorageService();
    final remote = RemoteDataSourceImpl(services: apiService);
    final local = LocalDataSourceImpl(service: storageService);
    final repo = ArticleRepositoryImpl(remoteDataSource: remote,localDataSource: local);
    final headLinesUsecase = GetHeadLinesUseCase(repo: repo);
    final bookMarkUsecase = GetBookMarksUseCase(repo: repo);
    final addBookMarkUsecase = AddBookMarkUseCase( source: repo);
    final removeBookMarkUsecase = RemoveBookMarkUseCase(repo: repo);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsBloc(
            headLinesUseCase: headLinesUsecase,
          addBookMarkUseCase: addBookMarkUsecase,
          bookMarksUseCase: bookMarkUsecase,
          removeBookMarkUseCase: removeBookMarkUsecase
        )..add(GetDataEvent()),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
