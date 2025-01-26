import 'package:flutter/foundation.dart';
import 'package:test_task/data/environment/env_service.dart';
import 'package:test_task/data/models/feed_photo.dart';
import 'package:test_task/data/network/feed/feed_service.dart';

import '../network/feed/feed_models.dart';

class FeedRepository {
  FeedRepository({
    required FeedService feedService,
    required EnvService envService,
  })  : _feedService = feedService,
        _envService = envService;

  final FeedService _feedService;
  final EnvService _envService;

  Future<List<FeedPhoto>?> getPhotos({bool sorted = true}) async {
    try {
      final apiKey = _envService.getPexelsApiKey();

      final feedResponse = await _feedService.getFeed(apiKey);
      final List<Photo> feedResponsePhotos;

      if (sorted) {
        feedResponsePhotos = await compute(_getSortedPhotos, feedResponse.toJson());
      } else {
        feedResponsePhotos = feedResponse.photos;
      }

      final feedPhotos = [
        for (final responsePhoto in feedResponsePhotos)
          FeedPhoto.fromFeedResponsePhoto(responsePhoto)
      ];

      return feedPhotos;
    } catch (e) {
      // handle error if necessary
      return null;
    }
  }
}

List<Photo> _getSortedPhotos(Map<String, dynamic> json) {
  final feedResponse = FeedResponse.fromJson(json);
  final photos = feedResponse.photos;

  photos.sort((a, b) =>
      a.photographer.toUpperCase().compareTo(b.photographer.toUpperCase()));

  return photos;
}
