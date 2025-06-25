import 'package:matches/features/matches/domain/models/match.dart';

class MockMatchService {
  Future<List<MatchModel>> getUpcomingMatches() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      MatchModel(
        teamA: 'Team A',
        teamB: 'Team B',
        matchTime: DateTime.now().add(const Duration(days: 1)),
      ),
      MatchModel(
        teamA: 'Team C',
        teamB: 'Team D',
        matchTime: DateTime.now().add(const Duration(days: 2)),
      ),
      MatchModel(
        teamA: 'Team E',
        teamB: 'Team F',
        matchTime: DateTime.now().add(const Duration(days: 3)),
      ),
    ];
  }
}
