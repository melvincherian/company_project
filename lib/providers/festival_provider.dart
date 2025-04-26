import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FestivalProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String? _responseMessage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get responseMessage => _responseMessage;

  final String _url = 'https://posterbnaobackend.onrender.com/api/poster/festival';

  Future<void> postFestivalData(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    _responseMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _responseMessage = jsonDecode(response.body)['message'] ?? 'Success';
      } else {
        _error = 'Failed to post data. Code: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
