// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiServices.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiServices extends ApiServices {
  _$ApiServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiServices;

  @override
  Future<Response<dynamic>> getHeadlines() {
    final Uri $url = Uri.parse(
        '/top-headlines?excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=805e3a6c1b404db5a481418ec3cffbbb');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
