import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/core/dependency_injection/locator.dart';
import 'package:matches/features/matches/domain/models/match.dart';
import 'package:matches/features/matches/presentation/bloc/matchListBloc/match_list_bloc.dart';
import 'package:matches/features/matches/presentation/bloc/matchListBloc/match_list_event.dart';
import 'package:matches/features/matches/presentation/bloc/matchListBloc/match_list_state.dart';
import 'package:matches/features/matches/presentation/widgets/match_card.dart';
import 'package:matches/features/matches/presentation/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToDetail(BuildContext context, MatchModel match) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(match: match)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<MatchListBloc>()..add(FetchMatches()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Upcoming Matches')),
        body: BlocBuilder<MatchListBloc, MatchListState>(
          builder: (context, state) {
            if (state is MatchListLoading || state is MatchListInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MatchListLoaded) {
              return ListView.builder(
                itemCount: state.matches.length,
                itemBuilder: (context, index) {
                  final match = state.matches[index];
                  return MatchCard(
                    match: match,
                    onTap: () => _navigateToDetail(context, match),
                  );
                },
              );
            } else if (state is MatchListError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
}
