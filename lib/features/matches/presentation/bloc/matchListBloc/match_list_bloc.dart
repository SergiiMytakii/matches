import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/features/matches/domain/repositories/match_repository.dart';
import 'package:matches/features/matches/presentation/bloc/matchListBloc/match_list_event.dart';
import 'package:matches/features/matches/presentation/bloc/matchListBloc/match_list_state.dart';

class MatchListBloc extends Bloc<MatchListEvent, MatchListState> {
  final MatchRepository matchRepository;

  MatchListBloc({required this.matchRepository}) : super(MatchListInitial()) {
    on<FetchMatches>((event, emit) async {
      emit(MatchListLoading());
      try {
        final matches = await matchRepository.getUpcomingMatches();
        emit(MatchListLoaded(matches));
      } catch (e) {
        emit(MatchListError('Failed to fetch matches: $e'));
      }
    });
  }
}
