import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/core/dependency_injection/locator.dart';
import 'package:matches/features/matches/domain/models/match.dart';
import 'package:matches/features/matches/presentation/bloc/predictionBloc/prediction_bloc.dart';
import 'package:matches/features/matches/presentation/bloc/predictionBloc/prediction_event.dart';
import 'package:matches/features/matches/presentation/bloc/predictionBloc/prediction_state.dart';

class DetailScreen extends StatelessWidget {
  final MatchModel match;

  const DetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<PredictionBloc>()..add(FetchPrediction(match)),
      child: Scaffold(
        appBar: AppBar(title: const Text('MatchModel Details')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${match.teamA} vs ${match.teamB}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Date & time: ${match.matchTime.toIso8601String().substring(0, 16).replaceAll('T', ' ')}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              BlocBuilder<PredictionBloc, PredictionState>(
                builder: (context, state) {
                  if (state is PredictionLoading ||
                      state is PredictionInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PredictionLoaded) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          state.prediction,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is PredictionError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Something went wrong!'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
