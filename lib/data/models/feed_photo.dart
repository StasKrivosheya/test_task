import 'package:test_task/data/network/feed/feed_models.dart';

class FeedPhoto {
  final String source;
  final String authorName;
  final String? alt;

  FeedPhoto({required this.source, required this.authorName, this.alt});

  factory FeedPhoto.fromFeedResponsePhoto(Photo photo) {
    final source = photo.src.original;
    final authorName = photo.photographer;
    final alt = photo.alt;

    return FeedPhoto(source: source, authorName: authorName, alt: alt);
  }
}
