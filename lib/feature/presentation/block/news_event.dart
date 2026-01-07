part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class ChangeTabEvent extends NewsEvent{
  final int index;

  const ChangeTabEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class GetHeadLinesEvent extends NewsEvent{

  @override
  List<Object?> get props => [];
}

class GetBookMarksEvent extends NewsEvent{

  @override
  List<Object?> get props => [];
}

class GetDataEvent extends NewsEvent{

  @override
  List<Object?> get props => [];
}

class AddBookMarksEvent extends NewsEvent{
  final String screenId;
  final ArticleEntity data;

  const AddBookMarksEvent({required this.data, required this.screenId});

  @override
  List<Object?> get props => [data, screenId];
}

class RemoveBookMarksEvent extends NewsEvent{
  final String screenId;
  final ArticleEntity data;

  const RemoveBookMarksEvent({required this.data, required this.screenId});

  @override
  List<Object?> get props => [data, screenId];
}
