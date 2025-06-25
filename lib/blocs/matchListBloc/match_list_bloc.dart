import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/blocs/matchListBloc/match_list_event.dart';
import 'package:matches/blocs/matchListBloc/match_list_state.dart';
import 'package:matches/repositories/match_repository.dart';

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
