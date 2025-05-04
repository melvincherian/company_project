import 'package:company_project/models/story_model.dart';
import 'package:flutter/material.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const StoryViewerScreen({
    Key? key,
    required this.stories,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late int _currentIndex;

  final storyDuration = const Duration(seconds: 5);

  late List<UserStories> userStoriesList; // 👈 Grouped stories by user
  late int _currentUserIndex; // 👈 Track current user

  @override
  void initState() {
    super.initState();

    userStoriesList = groupStoriesByUser(widget.stories);
    _currentUserIndex = getInitialUserIndex(widget.stories[widget.initialIndex].userId);
    _currentIndex = 0; // always start first story of current user

    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(vsync: this, duration: storyDuration);

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextStory();
        }
      });

    _animationController.forward();
  }

  int getInitialUserIndex(String userId) {
    return userStoriesList.indexWhere((u) => u.userId == userId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextStory() {
    if (_currentIndex < userStoriesList[_currentUserIndex].stories.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      // Move to next user's stories
      if (_currentUserIndex < userStoriesList.length - 1) {
        setState(() {
          _currentUserIndex++;
          _currentIndex = 0;
        });
        _animationController.reset();
        _animationController.forward();
      } else {
        Navigator.pop(context);
      }
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      // Move to previous user's stories
      if (_currentUserIndex > 0) {
        setState(() {
          _currentUserIndex--;
          _currentIndex = userStoriesList[_currentUserIndex].stories.length - 1;
        });
        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStory = userStoriesList[_currentUserIndex].stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.globalPosition.dx;

          if (tapPosition < screenWidth / 3) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          children: [
            Center(
              child: Image.network(
                'https://posterbnaobackend.onrender.com/${currentStory.images[0]}',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            // Caption
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: Text(
                currentStory.caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Progress bars
            Positioned(
              top: MediaQuery.of(context).padding.top + 70,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(
                  userStoriesList[_currentUserIndex].stories.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: LinearProgressIndicator(
                        value: index == _currentIndex ? _progressAnimation.value : index < _currentIndex ? 1.0 : 0.0,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Top bar
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _animationController.isAnimating ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      if (_animationController.isAnimating) {
                        _animationController.stop();
                      } else {
                        _animationController.forward();
                      }
                    },
                  ),
                ],
              ),
            ),
            // User stories avatar bar
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userStoriesList.length,
                  itemBuilder: (context, index) {
                    final userStory = userStoriesList[index];
                    final thumbnailUrl = 'https://posterbnaobackend.onrender.com/${userStory.stories.first.images[0]}';

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentUserIndex = index;
                          _currentIndex = 0;
                          _animationController.reset();
                          _animationController.forward();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: index == _currentUserIndex ? Colors.white : Colors.grey,
                          child: CircleAvatar(
                            radius: 23,
                            backgroundImage: NetworkImage(thumbnailUrl),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================
// Helper classes

class UserStories {
  final String userId;
  final List<Story> stories;

  UserStories({required this.userId, required this.stories});
}

List<UserStories> groupStoriesByUser(List<Story> stories) {
  final Map<String, List<Story>> grouped = {};

  for (var story in stories) {
    if (!grouped.containsKey(story.userId)) {
      grouped[story.userId] = [];
    }
    grouped[story.userId]!.add(story);
  }

  return grouped.entries
      .map((entry) => UserStories(userId: entry.key, stories: entry.value))
      .toList();
}
