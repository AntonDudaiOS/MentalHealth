import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/test_model.dart';

class FirebaseTestService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<QuantitativeTest>> loadTests(String filePath) async {
    final ref = _storage.ref().child(filePath);
    final data = await ref.getData();

    if (data == null) {
      throw Exception('Файл порожній або не знайдено');
    }

    final jsonString = utf8.decode(data);
    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map((e) => QuantitativeTest.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
