import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/usecase/usecase.dart';
import '../../domain/entities/articleEntity.dart';
import '../../domain/usecases/addBookMark.dart';
import '../../domain/usecases/getBookMarks.dart';
import '../../domain/usecases/getHeadlines.dart';
import '../../domain/usecases/removeBookMark.dart';
import '../widgets/headlinesListing.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  final GetHeadLinesUseCase _headLinesUseCase;
  final GetBookMarksUseCase _bookMarksUseCase;
  final AddBookMarkUseCase _addBookMarkUseCase;
  final RemoveBookMarkUseCase _removeBookMarkUseCase;

  int activeTab = 0;
  List<ArticleEntity> latestArticles = [];
  List<ArticleEntity> bookMarks = [];
  ArticleEntity? articleDetail;

  bool listLoadingFlag = false;

  NewsBloc(
      {required GetHeadLinesUseCase headLinesUseCase,
      required GetBookMarksUseCase bookMarksUseCase,
      required AddBookMarkUseCase addBookMarkUseCase,
      required RemoveBookMarkUseCase removeBookMarkUseCase})
      : _headLinesUseCase = headLinesUseCase,
        _bookMarksUseCase = bookMarksUseCase,
        _addBookMarkUseCase = addBookMarkUseCase,
        _removeBookMarkUseCase = removeBookMarkUseCase,
        super(NewsInitial()) {
    on<NewsEvent>((event, emit) {});
    on<ChangeTabEvent>(_onChangeTab);
    on<GetDataEvent>(_onGetData);
    on<GetHeadLinesEvent>(_onGetHeadlines);
    on<GetBookMarksEvent>(_onGetBookMarks);
    on<AddBookMarksEvent>(_onAddBookMark);
    on<RemoveBookMarksEvent>(_onRemoveBookMark);
  }

  FutureOr<void> _onChangeTab(ChangeTabEvent event, Emitter<NewsState> emit) {
    emit(NewsInitial());
    activeTab = event.index;
    if (activeTab == 0) {
      add(GetHeadLinesEvent());
    }else{
      add(GetBookMarksEvent());
    }
    emit(NewsUpdateState());
  }

  FutureOr<void> _onGetData(GetDataEvent event, Emitter<NewsState> emit) async{
    emit(const LoadingState(screenId: HeadLinesListing.id));
    final bookMarksRes = await _getBookMarks();
    bookMarksRes.fold((error) {}, (data) {
      bookMarks.clear();
      bookMarks.addAll(_setBookMarkStateToBookMarks(data));
    });
    final headlineRes = await _getHeadLines();
    headlineRes.fold((error) {

    }, (data) {
      latestArticles.clear();
      latestArticles.addAll(_setBookMarkStateToHighLights(data));
      emit(const SuccessState(screenId: HeadLinesListing.id));
    });

  }

  FutureOr<void> _onGetHeadlines(
      GetHeadLinesEvent event, Emitter<NewsState> emit) async {
    emit(const LoadingState(screenId: HeadLinesListing.id));
    final result = await _getHeadLines();
    result.fold((error) {
      emit(FailureState(screenId: HeadLinesListing.id, errorMsg: error));
    }, (data) {
      latestArticles.clear();
      latestArticles.addAll(_setBookMarkStateToHighLights(data));
      emit(const SuccessState(screenId: HeadLinesListing.id));
    });
  }

  FutureOr<void> _onGetBookMarks(
      GetBookMarksEvent event, Emitter<NewsState> emit) async{
    emit(const LoadingState(screenId: HeadLinesListing.id));
    final result = await _getBookMarks();
    result.fold((error) {
      emit(FailureState(screenId: HeadLinesListing.id, errorMsg: error));
    }, (data) {
      bookMarks.clear();
      bookMarks.addAll(_setBookMarkStateToBookMarks(data));
      emit(const SuccessState(screenId: HeadLinesListing.id));
    });
  }

  FutureOr<void> _onAddBookMark(
      AddBookMarksEvent event, Emitter<NewsState> emit) async{
    final id = event.screenId;
    emit(LoadingState(screenId: id));
    final result = await _addBookMarkUseCase.call(event.data);
    result.fold((error) {
      emit(FailureState(screenId: id, errorMsg: error));
    }, (data) {
      final Map<String,dynamic>? result = _updateBookMarkToHighLights(event.data, true);
      if(result != null) latestArticles[result['index']] = result['obj'];
      emit(SuccessState(screenId: id));
    });
  }

  FutureOr<void> _onRemoveBookMark(
      RemoveBookMarksEvent event, Emitter<NewsState> emit) async{
    final id = event.screenId;
    emit(LoadingState(screenId: id));
    final result = await _removeBookMarkUseCase.call(event.data);
    result.fold((error) {
      emit(FailureState(screenId: id, errorMsg: error));
    }, (data) {
      final Map<String,dynamic>? result = _updateBookMarkToHighLights(event.data, false);
      if(result != null) latestArticles[result['index']] = result['obj'];
      emit(SuccessState(screenId: id));
    });
  }

  Future<Either<String, List<ArticleEntity>>> _getHeadLines() => _headLinesUseCase.call(NoParams());

  Future<Either<String, List<ArticleEntity>>> _getBookMarks() => _bookMarksUseCase.call(NoParams());

  List<ArticleEntity> _setBookMarkStateToHighLights(List<ArticleEntity> data){
    if(bookMarks.isNotEmpty){
      for(int i = 0; i < data.length; i++){
        final index = bookMarks.indexWhere((element) => element.publishedAt!.isAtSameMomentAs(data[i].publishedAt!));
        if(index > -1){
          var article = bookMarks[index];
          data[i] = article.copyWithBookMarkStatus(true);
        }
      }
    }
    return data;
  }

  List<ArticleEntity> _setBookMarkStateToBookMarks(List<ArticleEntity> data){
    for(int i = 0; i < data.length; i++){
      var obj = data[i];
      data[i] = obj.copyWithBookMarkStatus(true);
    }
    return data;
  }

  Map<String, dynamic>? _updateBookMarkToHighLights(ArticleEntity data, bool status){
    if(!status){
      final index = bookMarks.indexWhere((element) => element.publishedAt!.isAtSameMomentAs(data.publishedAt!));
      if(index > -1) bookMarks.removeAt(index);
    }
    if(articleDetail != null){
      var obj = articleDetail;
      articleDetail = obj!.copyWithBookMarkStatus(status);
    }

    final index = latestArticles.indexWhere((element) => data.publishedAt!.isAtSameMomentAs(element.publishedAt!));

    if(index > -1){
      var obj = latestArticles[index];
      latestArticles[index] = obj.copyWithBookMarkStatus(status);
      return {
        'obj': obj.copyWithBookMarkStatus(status),
        'index': index
      };
    }
    return null;
  }

}
