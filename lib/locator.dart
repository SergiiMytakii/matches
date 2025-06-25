import 'package:get_it/get_it.dart';
import 'package:matches/blocs/matchListBloc/match_list_bloc.dart';
import 'package:matches/blocs/predictionBloc/prediction_bloc.dart';
import 'package:matches/repositories/langchain_prediction_repository_impl.dart';
import 'package:matches/repositories/match_repository.dart';
import 'package:matches/repositories/mock_match_repository_impl.dart';
import 'package:matches/repositories/prediction_repository.dart';

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
