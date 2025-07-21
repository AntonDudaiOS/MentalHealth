import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, dynamic>> loadJsonFile(String filePath) async {
    try {
      final ref = _storage.ref().child(filePath);
      final data = await ref.getData();

      if (data == null) {
        throw Exception('Empty data returned from Firebase Storage');
      }

      final jsonString = utf8.decode(data);
      final jsonData = jsonDecode(jsonString);

      return jsonData;
    } catch (e) {
      throw Exception('Error loading JSON file: $e');
    }
  }
}
