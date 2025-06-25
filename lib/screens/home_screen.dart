import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/blocs/matchListBloc/match_list_bloc.dart';
import 'package:matches/blocs/matchListBloc/match_list_event.dart';
import 'package:matches/blocs/matchListBloc/match_list_state.dart';
import 'package:matches/locator.dart';
import 'package:matches/models/match.dart';
import 'package:matches/screens/detail_screen.dart';
import 'package:matches/widgets/match_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToDetail(BuildContext context, Match match) {
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
