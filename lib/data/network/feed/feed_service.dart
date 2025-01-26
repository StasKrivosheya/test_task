import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import 'feed_models.dart';

part 'feed_service.g.dart';

@RestApi(
  baseUrl: 'https://api.pexels.com/v1/',
  parser: Parser.FlutterCompute,
)
abstract class FeedService {
  factory FeedService(Dio dio, {String? baseUrl}) = _FeedService;

  @GET('/curated?per_page=50')
  Future<FeedResponse> getFeed(@Header('Authorization') String apiKey);
}

FutureOr<FeedResponse> deserializeFeedResponse(Map<String, dynamic> json) {
  return FeedResponse.fromJson(json);
}

FutureOr<Map<String, dynamic>> serializeFeedResponse(FeedResponse feedResponse) {
  return feedResponse.toJson();
}
