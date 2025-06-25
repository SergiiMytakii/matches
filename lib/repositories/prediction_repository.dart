import 'package:matches/models/match.dart';

abstract class PredictionRepository {
  Future<String> getMatchPrediction({required Match match});
}
