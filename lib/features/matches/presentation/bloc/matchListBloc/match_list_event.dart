import 'package:equatable/equatable.dart';

abstract class MatchListEvent extends Equatable {
  const MatchListEvent();

  @override
  List<Object> get props => [];
}

class FetchMatches extends MatchListEvent {}
