import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'feed_models.dart';

part 'feed_service.g.dart';

@RestApi(baseUrl: 'https://api.pexels.com/v1/')
abstract class FeedService {
  factory FeedService(Dio dio, {String? baseUrl}) = _FeedService;
  
  @GET('/curated?per_page=50')
  Future<FeedResponse> getFeed(@Header('Authorization') String apiKey);
}
