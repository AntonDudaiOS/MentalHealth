import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';

class TestResultService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  TestResultService({required this.firestore, required this.auth});

  Future<void> saveResult({
    required QuantitativeTest test,
    required int score,
    required ResultDescription result,
  }) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('Користувач не авторизований');
    }

    final userId = user.uid;
    final testResultsRef = firestore
        .collection('users')
        .doc(userId)
        .collection('test_results');

    final now = Timestamp.now();
    final startOfDay = Timestamp.fromDate(
      DateTime(now.toDate().year, now.toDate().month, now.toDate().day),
    );

    final existingResults = await testResultsRef
        .where('testId', isEqualTo: test.id)
        .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
        .get();

    final data = {
      'userId': userId,
      'testId': test.id,
      'testTitle': test.title,
      'category': test.category,
      'score': score,
      'resultDescription': result.description,
      'timestamp': now,
    };

    if (existingResults.docs.isNotEmpty) {
      // Update the latest result for today
      final docId = existingResults.docs.first.id;
      await testResultsRef.doc(docId).set(data);
    } else {
      // Add a new result
      await testResultsRef.add(data);
    }
  }
}
