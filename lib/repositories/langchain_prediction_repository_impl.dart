import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:matches/models/match.dart';
import 'package:matches/repositories/prediction_repository.dart';

class LangChainPredictionRepositoryImpl implements PredictionRepository {
  static const _apiKey = String.fromEnvironment('OPENAI_API_KEY');

  @override
  Future<String> getMatchPrediction({required Match match}) async {
    if (_apiKey.isEmpty) {
      return 'Error: OPENAI_API_KEY is not set.';
    }

    final openAI = ChatOpenAI(
      apiKey: _apiKey,
      defaultOptions: const ChatOpenAIOptions(
        model: 'gpt-4o-mini',
        temperature: 0.5,
        maxTokens: 100,
      ),
    );

    final prompt = PromptTemplate.fromTemplate(
      'Provide a brief prediction for the football match between {teamA} and {teamB} scheduled for {matchTime}.',
    );

    final chain = LLMChain(llm: openAI, prompt: prompt);

    try {
      final result = await chain.run({
        'teamA': match.teamA,
        'teamB': match.teamB,
        'matchTime': match.matchTime.toIso8601String(),
      });
      return result;
    } catch (e) {
      return 'Failed to get prediction: $e';
    }
  }
}
