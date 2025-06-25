import 'package:matches/models/match.dart';

abstract class MatchRepository {
  Future<List<Match>> getUpcomingMatches();
}
