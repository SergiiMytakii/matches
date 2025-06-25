import 'package:equatable/equatable.dart';
import 'package:matches/features/matches/domain/models/match.dart';

abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object> get props => [];
}

class FetchPrediction extends PredictionEvent {
  final MatchModel match;

  const FetchPrediction(this.match);

  @override
  List<Object> get props => [match];
}
