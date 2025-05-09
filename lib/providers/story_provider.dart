// import 'dart:convert';
// import 'dart:io';
// import 'package:company_project/models/story_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class StoryProvider extends ChangeNotifier {
//   final List<Story> _stories = [];
//   bool _isLoading = false;
//   String? _error;
//   String? _currentUserId;

//   List<Story> get stories => _stories;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   // Set current user ID
//   void setCurrentUserId(String userId) {
//     _currentUserId = userId;
//     notifyListeners();
//   }

//   // Check if current user has a story
//   bool hasActiveStory() {
//     if (_currentUserId == null) return false;
    
//     // Get stories grouped by user
//     final userStoriesList = getUserStoriesList();
    
//     // Check if current user exists in the grouped stories
//     return userStoriesList.any((userStories) => 
//       userStories.userId == _currentUserId && 
//       userStories.stories.any((story) => DateTime.now().isBefore(story.expiredAt))
//     );
//   }

//   // Group stories by user
//   List<UserStories> getUserStoriesList() {
//     final Map<String, List<Story>> grouped = {};
    
//     // Only include stories that are not expired
//     final activeStories = _stories.where(
//       (story) => DateTime.now().isBefore(story.expiredAt)
//     ).toList();

//     for (var story in activeStories) {
//       if (!grouped.containsKey(story.userId)) {
//         grouped[story.userId] = [];
//       }
//       grouped[story.userId]!.add(story);
//     }

//     return grouped.entries
//         .map((entry) => UserStories(userId: entry.key, stories: entry.value))
//         .toList();
//   }

//   // Get current user's stories
//   UserStories? getCurrentUserStories() {
//     if (_currentUserId == null) return null;
    
//     final userStoriesList = getUserStoriesList();
    
//     try {
//       return userStoriesList.firstWhere(
//         (userStories) => userStories.userId == _currentUserId
//       );
//     } catch (e) {
//       return null; // No active stories found for current user
//     }
//   }

//   // Get only other users' stories (excluding current user's)
//   List<UserStories> getOtherUsersStories() {
//     if (_currentUserId == null) return getUserStoriesList();
    
//     final userStoriesList = getUserStoriesList();
    
//     return userStoriesList.where(
//       (userStories) => userStories.userId != _currentUserId
//     ).toList();
//   }

//   // Fetch all stories
//   Future<void> fetchStories() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final response = await http.get(
//         Uri.parse('https://posterbnaobackend.onrender.com/api/users/getAllStories'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         if (data['stories'] != null && data['stories'] is List) {
//           _stories.clear();
          
//           for (var storyJson in data['stories']) {
//             try {
//               final story = Story.fromJson(storyJson);
//               // Only add stories that haven't expired
//               if (DateTime.now().isBefore(story.expiredAt)) {
//                 _stories.add(story);
//               }
//             } catch (e) {
//               print('Error parsing story: $e');
//             }
//           }
//         } else {
//           _error = 'Invalid stories data format';
//         }
//       } else {
//         _error = 'Failed to load stories. Status code: ${response.statusCode}';
//       }
//     } catch (e) {
//       _error = 'Error fetching stories: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Post a new story
//   Future<bool> postStory(File imageFile, String caption, String userId) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

    // try {
    //   // Create multipart request
    //   var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse('https://posterbnaobackend.onrender.com/api/users/post/$userId'),
    //   );

    //   // Add form fields
    //   request.fields['caption'] = caption;

    //   // Add file
    //   var imageStream = http.ByteStream(imageFile.openRead());
    //   var length = await imageFile.length();
    //   var fileExtension = extension(imageFile.path).replaceAll('.', '');
      
    //   var multipartFile = http.MultipartFile(
    //     'file',
    //     imageStream,
    //     length,
    //     filename: basename(imageFile.path),
    //     contentType: MediaType('image', fileExtension),
    //   );
      
    //   request.files.add(multipartFile);

    //   // Send request
    //   var streamedResponse = await request.send();
    //   var response = await http.Response.fromStream(streamedResponse);

    //   if (response.statusCode == 201 || response.statusCode == 200) {
    //     await fetchStories(); // Refresh stories
    //     return true;
    //   } else {
    //     _error = 'Failed to post story. Status code: ${response.statusCode}';
    //     return false;
    //   }
    // } catch (e) {
    //   _error = 'Error posting story: $e';
    //   return false;
    // } finally {
    //   _isLoading = false;
    //   notifyListeners();
    // }
//   }

//   // Pick image from gallery or camera
//   Future<File?> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
    
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     }
//     return null;
//   }
// }

// // Helper class to group stories by user
// class UserStories {
//   final String userId;
//   final List<Story> stories;

//   UserStories({required this.userId, required this.stories});
// }






import 'dart:convert';
import 'dart:io';

import 'package:company_project/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;




class StoryProvider extends ChangeNotifier {
  final List<Story> _stories = [];
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;
  String? _currentUserImage;
  String? _currentUsername;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentUserImage => _currentUserImage;
  String? get currentUsername => _currentUsername;
  String? get currentUserId => _currentUserId;


  // Set current user info
  void setCurrentUser({required String userId, String? userImage, String? username}) {
    _currentUserId = userId;
    _currentUserImage = userImage;
    _currentUsername = username;
    notifyListeners();
  }

  // Check if current user has an active story
  bool currentUserHasStory() {
    if (_currentUserId == null) return false;
    
    return _stories.any((story) => 
      story.userId == _currentUserId && 
      DateTime.now().isBefore(story.expiredAt)
    );
  }

  // Get all active stories grouped by user
  List<UserStories> getUserStoriesList() {
    final Map<String, List<Story>> grouped = {};
    
    // Only include non-expired stories
    final activeStories = _stories.where(
      (story) => DateTime.now().isBefore(story.expiredAt)
    ).toList();

    for (var story in activeStories) {
      if (!grouped.containsKey(story.userId)) {
        grouped[story.userId] = [];
      }
      grouped[story.userId]!.add(story);
    }

    // Create UserStories objects
    return grouped.entries
        .map((entry) => UserStories(userId: entry.key, stories: entry.value))
        .toList();
  }

  // Get stories for display in the main feed
  List<UserStories> getStoriesForDisplay() {
    final allUserStories = getUserStoriesList();
    
    // If current user has stories, ensure they appear first
    if (_currentUserId != null) {
      final currentUserIndex = allUserStories.indexWhere(
        (userStories) => userStories.userId == _currentUserId
      );
      
      if (currentUserIndex > 0) {
        // Remove and insert at the beginning
        final currentUserStories = allUserStories.removeAt(currentUserIndex);
        allUserStories.insert(0, currentUserStories);
      }
    }
    
    return allUserStories;
  }

  // Mark a story as viewed
  void markStoryAsViewed(String storyId) {
    final index = _stories.indexWhere((story) => story.id == storyId);
    if (index != -1) {
      _stories[index] = _stories[index].copyWith(isViewed: true);
      notifyListeners();
    }
  }

  // Fetch all stories
  Future<void> fetchStories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulated API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Implementation of your actual API call goes here
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
              print('oooooooooooooooooooooooooooooooooooooo$_stories');
            } catch (e) {
              print('Error parsing story: $e');
            }
          }
        }
      }
      
    } catch (e) {
      _error = 'Error fetching stories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Post a new story
  Future<bool> postStory(File imageFile, String caption) async {
          print("Reeeeeeeeeeeeeeeeeeeeeeeeeee${imageFile}");

    if (_currentUserId == null) return false;
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Implementation of your actual API call goes here
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://posterbnaobackend.onrender.com/api/users/post/$_currentUserId'),
      );
      
      request.fields['caption'] = caption;
      
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
      
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Reeeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}");
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchStories(); // Refresh stories
        return true;
      }
      
      // Simulated success response
      await Future.delayed(const Duration(seconds: 1));
      await fetchStories();
      return true;
      
    } catch (e) {
      _error = 'Error posting story: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a story
  Future<bool> deleteStory(String storyId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Implementation of your actual API call goes here
      // final response = await http.delete(
      //   Uri.parse('https://posterbnaobackend.onrender.com/api/users/story/$storyId'),
      //   headers: {'Content-Type': 'application/json'},
      // );
      //
      // if (response.statusCode == 200) {
      //   // Remove the story from local list
      //   _stories.removeWhere((story) => story.id == storyId);
      //   notifyListeners();
      //   return true;
      // }
      
      // Simulated success response
      await Future.delayed(const Duration(seconds: 1));
      _stories.removeWhere((story) => story.id == storyId);
      notifyListeners();
      return true;
      
    } catch (e) {
      _error = 'Error deleting story: $e';
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