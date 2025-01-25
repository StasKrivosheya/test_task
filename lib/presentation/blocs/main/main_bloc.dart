import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_task/data/models/feed_photo.dart';
import 'package:test_task/data/repositories/feed_repository.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({required feedRepository})
      : _feedRepository = feedRepository,
        super(MainState(photos: [], status: MainStatus.loading)) {
    on<MainFetchFeedRequested>(_onMainFetchFeedRequested);
  }

  final FeedRepository _feedRepository;

  void _onMainFetchFeedRequested(
      MainFetchFeedRequested event, Emitter<MainState> emit) async {
    emit(state.copyWith(status: MainStatus.loading));

    final photos = await _feedRepository.getPhotos(sorted: true);

    if (photos == null) {
      emit(state.copyWith(status: MainStatus.error));
    } else if (photos.isEmpty) {
      emit(state.copyWith(status: MainStatus.empty));
    } else {
      emit(state.copyWith(status: MainStatus.data, photos: photos));
    }
  }
}
