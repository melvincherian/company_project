import 'package:company_project/models/category_modell.dart';
import 'package:company_project/providers/category_provider.dart';
import 'package:company_project/providers/category_providerr.dart';
import 'package:company_project/views/presentation/pages/home/poster/poster_maker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<CategoryModel> items = [];
  List<dynamic> _filteredCategories = [];
  bool serchValue = false;
  bool _isListening = false;
  final stt.SpeechToText _speech = stt.SpeechToText();

  late final CategoryProviderr categoryprovider;

  @override
  void initState() {
    super.initState();
    categoryprovider = Provider.of<CategoryProviderr>(context, listen: false);
    _initSpeech();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Initialize speech recognition
  Future<void> _initSpeech() async {
    await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        setState(() => _isListening = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
  }

  // Request microphone permission
  Future<bool> _requestMicPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    return status.isGranted;
  }

  // Start listening to voice input
  Future<void> _startListening() async {
    bool hasPermission = await _requestMicPermission();
    
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission is required')),
      );
      return;
    }

    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              setState(() {
                searchController.text = result.recognizedWords;
                _isListening = false;
              });
              handleSearch(result.recognizedWords);
            }
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 5),
          partialResults: false,
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available')),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _fetchCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories();
    setState(() {
      _filteredCategories =
          Provider.of<CategoryProvider>(context, listen: false).categories;
    });
  }

  void handleSearch(String query) {
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      setState(() {
        serchValue = false;
        items = [];
      });
    } else {
      final searchedItems = categoryprovider.searchItems(trimmedQuery);
      print('melvin$searchedItems');
      setState(() {
        serchValue = true;
        items = searchedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    if (_filteredCategories.isEmpty && categoryProvider.categories.isNotEmpty) {
      _filteredCategories = categoryProvider.categories;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.red : const Color.fromARGB(255, 36, 0, 74),size: 25,
                  ),
                  onPressed: _startListening,
                  tooltip: 'Voice Search',
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              controller: searchController,
              onChanged: handleSearch,
            ),
          ),
          if (_isListening)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.mic, color: Colors.red, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Listening...',
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: serchValue
                ? items.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: item.images != null
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PosterMakerApp(
                                                    poster: item,
                                                    isCustom: false,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              item.images[0],
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child: Icon(
                                                  Icons.image_not_supported)),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("No results found"))
                : const Center(child: Text("Start typing to search...")),
          ),
        ],
      ),
    );
  }
}