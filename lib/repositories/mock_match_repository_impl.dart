import 'package:matches/models/match.dart';
import 'package:matches/repositories/match_repository.dart';

class MockMatchRepositoryImpl implements MatchRepository {
  @override
  Future<List<Match>> getUpcomingMatches() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      Match(
        teamA: 'Team Alpha',
        teamB: 'Team Beta',
        matchTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      ),
      Match(
        teamA: 'Team Gamma',
        teamB: 'Team Delta',
        matchTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      ),
      Match(
        teamA: 'Team Epsilon',
        teamB: 'Team Zeta',
        matchTime: DateTime.now().add(const Duration(days: 3, hours: 6)),
      ),
    ];
  }
}
