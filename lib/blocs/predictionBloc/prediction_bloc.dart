import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/blocs/predictionBloc/prediction_event.dart';
import 'package:matches/blocs/predictionBloc/prediction_state.dart';
import 'package:matches/repositories/prediction_repository.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final PredictionRepository predictionRepository;

  PredictionBloc({required this.predictionRepository})
    : super(PredictionInitial()) {
    on<FetchPrediction>((event, emit) async {
      emit(PredictionLoading());
      try {
        final prediction = await predictionRepository.getMatchPrediction(
          match: event.match,
        );
        emit(PredictionLoaded(prediction));
      } catch (e) {
        emit(PredictionError('Failed to fetch prediction: $e'));
      }
    });
  }
}
