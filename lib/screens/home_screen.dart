import 'package:flutter/material.dart';
import 'package:matches/models/match.dart';
import 'package:matches/screens/detail_screen.dart';
import 'package:matches/services/mock_match_service.dart';
import 'package:matches/widgets/match_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MockMatchService _matchService = MockMatchService();
  List<Match> _matches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      final matches = await _matchService.getUpcomingMatches();
      setState(() {
        _matches = matches;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately in a real app
      print(e);
    }
  }

  void _navigateToDetail(Match match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(match: match),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Matches'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _matches.length,
              itemBuilder: (context, index) {
                final match = _matches[index];
                return MatchCard(
                  match: match,
                  onTap: () => _navigateToDetail(match),
                );
              },
            ),
    );
  }
}
