import 'package:flutter_test/flutter_test.dart';
import 'package:matches/services/mock_match_service.dart';

void main() {
  test('MockMatchService should return a list of 3 matches', () async {
    // Arrange
    final service = MockMatchService();

    // Act
    final matches = await service.getUpcomingMatches();

    // Assert
    expect(matches.length, 3);
  });
}
