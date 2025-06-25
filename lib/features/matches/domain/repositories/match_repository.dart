import 'package:matches/features/matches/domain/models/match.dart';

abstract class MatchRepository {
  Future<List<MatchModel>> getUpcomingMatches();
}
