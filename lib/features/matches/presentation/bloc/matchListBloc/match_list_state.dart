import 'package:equatable/equatable.dart';
import 'package:matches/features/matches/domain/models/match.dart';

abstract class MatchListState extends Equatable {
  const MatchListState();

  @override
  List<Object> get props => [];
}

class MatchListInitial extends MatchListState {}

class MatchListLoading extends MatchListState {}

class MatchListLoaded extends MatchListState {
  final List<MatchModel> matches;

  const MatchListLoaded(this.matches);

  @override
  List<Object> get props => [matches];
}

class MatchListError extends MatchListState {
  final String message;

  const MatchListError(this.message);

  @override
  List<Object> get props => [message];
}
