import 'package:matches/features/matches/domain/models/match.dart';
import 'package:matches/features/matches/domain/repositories/match_repository.dart';

class MockMatchRepositoryImpl implements MatchRepository {
  @override
  Future<List<MatchModel>> getUpcomingMatches() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      MatchModel(
        teamA: 'Team Alpha',
        teamB: 'Team Beta',
        matchTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
        teamAResults: 'W-L-L-D-W',
        teamBResults: 'L-L-W-L-L',
      ),
      MatchModel(
        teamA: 'Team Gamma',
        teamB: 'Team Delta',
        matchTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
        teamAResults: 'W-W-W-W-W',
        teamBResults: 'L-L-W-D-L',
      ),
      MatchModel(
        teamA: 'Team Epsilon',
        teamB: 'Team Zeta',
        matchTime: DateTime.now().add(const Duration(days: 3, hours: 6)),
        teamAResults: 'W-W-L-D-W',
        teamBResults: 'L-L-W-D-L',
      ),
    ];
  }
}
