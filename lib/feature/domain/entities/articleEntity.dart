import 'package:equatable/equatable.dart';

import '../../data/models/articleModel.dart';

class ArticleEntity extends Equatable {
  final String? sourceId;
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;
  final bool? bookMarked;

  const ArticleEntity({
    required this.sourceId,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.bookMarked
  });

  @override
  List<Object?> get props => [
    sourceId,
    sourceName,
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
    bookMarked
  ];

  ArticleEntity copyWithBookMarkStatus(bool status){
    return ArticleEntity(sourceId: sourceId, sourceName: sourceName, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, bookMarked: status);
  }


  factory ArticleEntity.fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      sourceId: json['source']['id'],
      sourceName: json['source']['name'],
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? "",
      bookMarked: null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {'id': sourceId, 'name': sourceName},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
    };
  }

  ArticleModel get model=>ArticleModel(sourceId: sourceId, sourceName: sourceName, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, bookMarked: bookMarked
  );



  bool get isArticleRemoved => title != null && title == '[Removed]';
}