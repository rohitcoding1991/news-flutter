import 'package:chopper/chopper.dart';

import 'urls.dart';

part 'apiServices.chopper.dart';

@ChopperApi()
abstract class ApiServices extends ChopperService{
  static ApiServices create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(Urls.baseUrl),
      services: [_$ApiServices()],
      converter: const JsonConverter(),
    );
    return _$ApiServices(client);
  }

  @Get(path: Urls.headLines)
  Future<Response> getHeadlines();
}