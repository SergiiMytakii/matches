import 'package:matches/features/matches/domain/models/match.dart';

abstract class PredictionRepository {
  Future<String> getMatchPrediction({required MatchModel match});
}
