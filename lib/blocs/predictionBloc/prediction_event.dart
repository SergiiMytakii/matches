import 'package:equatable/equatable.dart';
import 'package:matches/models/match.dart';

abstract class PredictionEvent extends Equatable {
  const PredictionEvent();

  @override
  List<Object> get props => [];
}

class FetchPrediction extends PredictionEvent {
  final Match match;

  const FetchPrediction(this.match);

  @override
  List<Object> get props => [match];
}
