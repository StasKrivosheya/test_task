part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();
}

final class MainFetchFeedRequested extends MainEvent {
  @override
  List<Object?> get props => [];
}
