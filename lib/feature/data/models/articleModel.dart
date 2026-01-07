import 'package:hive/hive.dart';
import 'package:news_flutter/core/utils/dateTimeUtils.dart';

import '../../domain/entities/articleEntity.dart';

part 'articleModel.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends ArticleEntity {

  @HiveField(0)
  final String? sourceId;

  @HiveField(1)
  final String? sourceName;

  @HiveField(2)
  final String? author;

  @HiveField(3)
  final String? title;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final String? url;

  @HiveField(6)
  final String? urlToImage;

  @HiveField(7)
  final DateTime? publishedAt;

  @HiveField(8)
  final String? content;

  // @HiveField(9)
  final bool? bookMarked;

  const ArticleModel({
    required  this.sourceId,
    required this. sourceName,
    required this. author,
    required this. title,
    required this. description,
    required this. url,
    required this. urlToImage,
    required this. publishedAt,
    required this. content,
    required this.bookMarked,
  }) : super(
    sourceId: sourceId,
    sourceName: sourceName,
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
    bookMarked: bookMarked
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final String dateString = json['publishedAt'] ?? "";
    return ArticleModel(
      sourceId: json['source']?['id'],
      sourceName: json['source']?['name'],
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: dateString.isNotEmpty ? dateString.yyyy_MM_ddTHH_mm_ss : null,
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

  ArticleEntity toEntity(){
    return ArticleEntity(sourceId: sourceId, sourceName: sourceName, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, bookMarked: bookMarked
    );
  }
}


class Source {
  String? id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}