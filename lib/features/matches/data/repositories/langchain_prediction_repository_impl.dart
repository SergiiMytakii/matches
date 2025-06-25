import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:matches/features/matches/domain/models/match.dart';
import 'package:matches/features/matches/domain/repositories/prediction_repository.dart';

class LangChainPredictionRepositoryImpl implements PredictionRepository {
  static const _apiKey = String.fromEnvironment('OPENAI_API_KEY');

  @override
  Future<String> getMatchPrediction({required MatchModel match}) async {
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
      "Given {teamA}'s last 5 results (W-W-L-D-W) and {teamB}'s last 5 results (L-L-W-D-L), predict the winner for the match between {teamA} and {teamB} scheduled for {matchTime}. Provide a brief prediction and a confidence percentage. Format your response as: Prediction: [Your Prediction] | Confidence: [Your Confidence]%.",
    );

    final chain = LLMChain(llm: openAI, prompt: prompt);

    try {
      final result = await chain.invoke({
        'teamA': match.teamA,
        'teamB': match.teamB,
        'matchTime': match.matchTime.toIso8601String(),
      });
      return result['output'].content;
    } catch (e) {
      return 'Failed to get prediction: $e';
    }
  }
}
