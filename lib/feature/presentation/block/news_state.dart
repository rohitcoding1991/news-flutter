part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsUpdateState extends NewsState {
  @override
  List<Object> get props => [];
}

class SuccessState extends NewsState {
  final String screenId;

  const SuccessState({required this.screenId});
  @override
  List<Object> get props => [screenId];
}

class LoadingState extends NewsState {
  final String screenId;

  const LoadingState({required this.screenId});
  @override
  List<Object> get props => [screenId];
}

class FailureState extends NewsState {
  final String screenId;
  final String errorMsg;

  const FailureState({required this.screenId, required this.errorMsg});
  @override
  List<Object> get props => [screenId, errorMsg];
}
