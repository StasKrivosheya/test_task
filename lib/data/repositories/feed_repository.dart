import 'package:test_task/data/environment/env_service.dart';
import 'package:test_task/data/models/feed_photo.dart';
import 'package:test_task/data/network/feed/feed_service.dart';

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

      // TODO: sort in Isolate
      if (sorted) {
        feedResponse.photos.sort((a, b) => a.photographer
            .toUpperCase()
            .compareTo(b.photographer.toUpperCase()));
      }

      final feedPhotos = [
        for (final responsePhoto in feedResponse.photos)
          FeedPhoto.fromFeedResponsePhoto(responsePhoto)
      ];

      return feedPhotos;
    } catch (e) {
      // handle error if necessary
      return null;
    }
  }
}
