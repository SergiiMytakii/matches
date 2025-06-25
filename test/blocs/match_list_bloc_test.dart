import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matches/blocs/matchListBloc/match_list_bloc.dart';
import 'package:matches/blocs/matchListBloc/match_list_event.dart';
import 'package:matches/blocs/matchListBloc/match_list_state.dart';
import 'package:matches/models/match.dart';
import 'package:matches/repositories/match_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'match_list_bloc_test.mocks.dart';

@GenerateMocks([MatchRepository])
void main() {
  late MatchListBloc matchListBloc;
  late MockMatchRepository mockMatchRepository;

  setUp(() {
    mockMatchRepository = MockMatchRepository();
    matchListBloc = MatchListBloc(matchRepository: mockMatchRepository);
  });

  tearDown(() {
    matchListBloc.close();
  });

  final mockMatches = [
    Match(teamA: 'A', teamB: 'B', matchTime: DateTime.now()),
  ];

  blocTest<MatchListBloc, MatchListState>(
    'emits [MatchListLoading, MatchListLoaded] when matches are fetched successfully',
    build: () {
      when(
        mockMatchRepository.getUpcomingMatches(),
      ).thenAnswer((_) async => mockMatches);
      return matchListBloc;
    },
    act: (bloc) => bloc.add(FetchMatches()),
    expect: () => [isA<MatchListLoading>(), isA<MatchListLoaded>()],
  );

  blocTest<MatchListBloc, MatchListState>(
    'emits [MatchListLoading, MatchListError] when fetching matches fails',
    build: () {
      when(
        mockMatchRepository.getUpcomingMatches(),
      ).thenThrow(Exception('Failed to fetch matches'));
      return matchListBloc;
    },
    act: (bloc) => bloc.add(FetchMatches()),
    expect: () => [isA<MatchListLoading>(), isA<MatchListError>()],
  );
}
