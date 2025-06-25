import 'package:get_it/get_it.dart';
import 'package:matches/features/matches/data/repositories/langchain_prediction_repository_impl.dart';
import 'package:matches/features/matches/data/repositories/mock_match_repository_impl.dart';
import 'package:matches/features/matches/domain/repositories/match_repository.dart';
import 'package:matches/features/matches/domain/repositories/prediction_repository.dart';
import 'package:matches/features/matches/presentation/bloc/predictionBloc/prediction_bloc.dart';

import '../../features/matches/presentation/bloc/matchListBloc/match_list_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Repositories
  locator.registerLazySingleton<MatchRepository>(
    () => MockMatchRepositoryImpl(),
  );
  locator.registerLazySingleton<PredictionRepository>(
    () => LangChainPredictionRepositoryImpl(),
  );

  // BLoCs
  locator.registerFactory(
    () => MatchListBloc(matchRepository: locator<MatchRepository>()),
  );
  locator.registerFactory(
    () => PredictionBloc(predictionRepository: locator<PredictionRepository>()),
  );
}
