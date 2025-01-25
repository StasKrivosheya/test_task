import 'package:json_annotation/json_annotation.dart';

part 'feed_models.g.dart';

// Classes based on response json, generated and pasted from:
// Instantly generate Dart from JSON https://app.quicktype.io/

@JsonSerializable()
class FeedResponse {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "per_page")
  final int perPage;
  @JsonKey(name: "photos")
  final List<Photo> photos;
  @JsonKey(name: "next_page")
  final String nextPage;

  FeedResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.nextPage,
  });

  factory FeedResponse.fromJson(Map<String, dynamic> json) => _$FeedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedResponseToJson(this);
}

@JsonSerializable()
class Photo {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "width")
  final int width;
  @JsonKey(name: "height")
  final int height;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "photographer")
  final String photographer;
  @JsonKey(name: "photographer_url")
  final String photographerUrl;
  @JsonKey(name: "photographer_id")
  final int photographerId;
  @JsonKey(name: "avg_color")
  final String avgColor;
  @JsonKey(name: "src")
  final Src src;
  @JsonKey(name: "liked")
  final bool liked;
  @JsonKey(name: "alt")
  final String? alt;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.avgColor,
    required this.src,
    required this.liked,
    required this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class Src {
  @JsonKey(name: "original")
  final String original;
  @JsonKey(name: "large2x")
  final String large2X;
  @JsonKey(name: "large")
  final String large;
  @JsonKey(name: "medium")
  final String medium;
  @JsonKey(name: "small")
  final String small;
  @JsonKey(name: "portrait")
  final String portrait;
  @JsonKey(name: "landscape")
  final String landscape;
  @JsonKey(name: "tiny")
  final String tiny;

  Src({
    required this.original,
    required this.large2X,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory Src.fromJson(Map<String, dynamic> json) => _$SrcFromJson(json);

  Map<String, dynamic> toJson() => _$SrcToJson(this);
}
