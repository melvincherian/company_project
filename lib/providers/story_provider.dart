import 'dart:convert';
import 'dart:io';
import 'package:company_project/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryProvider extends ChangeNotifier {
  final List<Story> _stories = [];
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Set current user ID
  void setCurrentUserId(String userId) {
    _currentUserId = userId;
    notifyListeners();
  }

  // Check if current user has a story
  bool hasActiveStory() {
    if (_currentUserId == null) return false;
    
    // Get stories grouped by user
    final userStoriesList = getUserStoriesList();
    
    // Check if current user exists in the grouped stories
    return userStoriesList.any((userStories) => 
      userStories.userId == _currentUserId && 
      userStories.stories.any((story) => DateTime.now().isBefore(story.expiredAt))
    );
  }

  // Group stories by user
  List<UserStories> getUserStoriesList() {
    final Map<String, List<Story>> grouped = {};
    
    // Only include stories that are not expired
    final activeStories = _stories.where(
      (story) => DateTime.now().isBefore(story.expiredAt)
    ).toList();

    for (var story in activeStories) {
      if (!grouped.containsKey(story.userId)) {
        grouped[story.userId] = [];
      }
      grouped[story.userId]!.add(story);
    }

    return grouped.entries
        .map((entry) => UserStories(userId: entry.key, stories: entry.value))
        .toList();
  }

  // Get current user's stories
  UserStories? getCurrentUserStories() {
    if (_currentUserId == null) return null;
    
    final userStoriesList = getUserStoriesList();
    
    try {
      return userStoriesList.firstWhere(
        (userStories) => userStories.userId == _currentUserId
      );
    } catch (e) {
      return null; // No active stories found for current user
    }
  }

  // Get only other users' stories (excluding current user's)
  List<UserStories> getOtherUsersStories() {
    if (_currentUserId == null) return getUserStoriesList();
    
    final userStoriesList = getUserStoriesList();
    
    return userStoriesList.where(
      (userStories) => userStories.userId != _currentUserId
    ).toList();
  }

  // Fetch all stories
  Future<void> fetchStories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://posterbnaobackend.onrender.com/api/users/getAllStories'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['stories'] != null && data['stories'] is List) {
          _stories.clear();
          
          for (var storyJson in data['stories']) {
            try {
              final story = Story.fromJson(storyJson);
              // Only add stories that haven't expired
              if (DateTime.now().isBefore(story.expiredAt)) {
                _stories.add(story);
              }
            } catch (e) {
              print('Error parsing story: $e');
            }
          }
        } else {
          _error = 'Invalid stories data format';
        }
      } else {
        _error = 'Failed to load stories. Status code: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Error fetching stories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Post a new story
  Future<bool> postStory(File imageFile, String caption, String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://posterbnaobackend.onrender.com/api/users/post/$userId'),
      );

      // Add form fields
      request.fields['caption'] = caption;

      // Add file
      var imageStream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var fileExtension = extension(imageFile.path).replaceAll('.', '');
      
      var multipartFile = http.MultipartFile(
        'file',
        imageStream,
        length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', fileExtension),
      );
      
      request.files.add(multipartFile);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchStories(); // Refresh stories
        return true;
      } else {
        _error = 'Failed to post story. Status code: ${response.statusCode}';
        return false;
      }
    } catch (e) {
      _error = 'Error posting story: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Pick image from gallery or camera
  Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}

// Helper class to group stories by user
class UserStories {
  final String userId;
  final List<Story> stories;

  UserStories({required this.userId, required this.stories});
}