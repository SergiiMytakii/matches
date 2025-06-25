import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matches/blocs/predictionBloc/prediction_bloc.dart';
import 'package:matches/blocs/predictionBloc/prediction_event.dart';
import 'package:matches/blocs/predictionBloc/prediction_state.dart';
import 'package:matches/models/match.dart';
import 'package:matches/repositories/prediction_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'prediction_bloc_test.mocks.dart';

@GenerateMocks([PredictionRepository])
void main() {
  late PredictionBloc predictionBloc;
  late MockPredictionRepository mockPredictionRepository;

  setUp(() {
    mockPredictionRepository = MockPredictionRepository();
    predictionBloc = PredictionBloc(
      predictionRepository: mockPredictionRepository,
    );
  });

  tearDown(() {
    predictionBloc.close();
  });

  final mockMatch = Match(teamA: 'A', teamB: 'B', matchTime: DateTime.now());
  const mockPrediction = 'Team A will win.';

  blocTest<PredictionBloc, PredictionState>(
    'emits [PredictionLoading, PredictionLoaded] when prediction is fetched successfully',
    build: () {
      when(
        mockPredictionRepository.getMatchPrediction(match: mockMatch),
      ).thenAnswer((_) async => mockPrediction);
      return predictionBloc;
    },
    act: (bloc) => bloc.add(FetchPrediction(mockMatch)),
    expect: () => [isA<PredictionLoading>(), isA<PredictionLoaded>()],
  );

  blocTest<PredictionBloc, PredictionState>(
    'emits [PredictionLoading, PredictionError] when fetching prediction fails',
    build: () {
      when(
        mockPredictionRepository.getMatchPrediction(match: mockMatch),
      ).thenThrow(Exception('Failed to fetch prediction'));
      return predictionBloc;
    },
    act: (bloc) => bloc.add(FetchPrediction(mockMatch)),
    expect: () => [isA<PredictionLoading>(), isA<PredictionError>()],
  );
}
