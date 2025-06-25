import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/blocs/predictionBloc/prediction_bloc.dart';
import 'package:matches/blocs/predictionBloc/prediction_event.dart';
import 'package:matches/blocs/predictionBloc/prediction_state.dart';
import 'package:matches/locator.dart';
import 'package:matches/models/match.dart';

class DetailScreen extends StatelessWidget {
  final Match match;

  const DetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<PredictionBloc>()..add(FetchPrediction(match)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Match Details')),
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
