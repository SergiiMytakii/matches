import 'package:matches/models/match.dart';

class MockMatchService {
  Future<List<Match>> getUpcomingMatches() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Match(
        teamA: 'Team A',
        teamB: 'Team B',
        matchTime: DateTime.now().add(const Duration(days: 1)),
      ),
      Match(
        teamA: 'Team C',
        teamB: 'Team D',
        matchTime: DateTime.now().add(const Duration(days: 2)),
      ),
      Match(
        teamA: 'Team E',
        teamB: 'Team F',
        matchTime: DateTime.now().add(const Duration(days: 3)),
      ),
    ];
  }
}
