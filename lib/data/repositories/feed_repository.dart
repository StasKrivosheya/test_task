import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_task/data/models/feed_photo.dart';
import 'package:test_task/data/network/feed/feed_service.dart';

class FeedRepository {
  final FeedService _feedService;

  // TODO: inject dotenv as well

  FeedRepository(this._feedService);

  Future<List<FeedPhoto>?> getPhotos() async {
    // TODO: get from env service
    final apiKey = dotenv.env['PEXELS_API_KEY']!;

    final feedResponse = await _feedService.getFeed(apiKey);
    final feedPhotos = [
      for (final responsePhoto in feedResponse.photos)
        FeedPhoto.fromFeedResponsePhoto(responsePhoto)
    ];

    return feedPhotos;
  }
}
