import 'dart:convert';
import 'dart:io';
import 'package:company_project/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class StoryProvider extends ChangeNotifier {
  final List<Story> _stories = [];
  bool _isLoading = false;
  String? _error;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all stories
Future<void> fetchStories() async {
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    print('Starting to fetch stories...');
    final response = await http.get(
      Uri.parse('https://posterbnaobackend.onrender.com/api/users/getAllStories'),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded data: $data');
      print('Stories from API: ${data['stories']}');
      
      if (data['stories'] != null && data['stories'] is List) {
        _stories.clear();
        print('Cleared existing stories. Adding new ones...');
        
        for (var storyJson in data['stories']) {
          print('Processing story: $storyJson');
          try {
            final story = Story.fromJson(storyJson);
            _stories.add(story);
            print('Added story: ${story.id}');
          } catch (e) {
            print('Error parsing story: $e');
          }
        }
        
        print('Total stories addedddddddddddddddddddddddddddddddddddddddd: ${_stories.length}');
      } else {
        print('Stories data is null or not a list: ${data['stories']}');
        _error = 'Invalid stories data format';
      }
    } else {
      _error = 'Failed to load stories. Status code: ${response.statusCode}';
      print('Error: $_error');
    }
  } catch (e) {
    _error = 'Error fetching stories: $e';
    print('Exception caught: $_error');
  } finally {
    _isLoading = false;
    print('Stories fetch completed. Stories count: ${_stories.length}');
    print('Stories content: $_stories');
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
    // final picker = ImagePickerPlugin();
    // final pickedFile = await picker.pickImage(source: source);
    
    // if (pickedFile != null) {
    //   return File(pickedFile.path);
    // }
    return null;
  }
}