part of 'main_bloc.dart';

enum MainStatus { loading, error, empty, data }

final class MainState extends Equatable {
  final List<FeedPhoto> photos;
  final MainStatus status;

  const MainState({
    required this.photos,
    required this.status,
  });

  MainState copyWith({
    List<FeedPhoto>? photos,
    MainStatus? status,
  }) {
    return MainState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [photos, status];
}
