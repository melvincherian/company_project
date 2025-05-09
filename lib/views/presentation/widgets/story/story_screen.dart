import 'package:company_project/models/story_model.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/views/presentation/widgets/story/add_story.dart';
import 'package:company_project/views/presentation/widgets/story/stories_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<UserStories> userStoriesList;
  final int initialUserIndex;

  const StoryViewerScreen({
    Key? key,
    required this.userStoriesList,
    required this.initialUserIndex,
  }) : super(key: key);

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late int _currentUserIndex;
  late int _currentStoryIndex;
  bool _isPaused = false;
  bool _isShowingUserOptions = false;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialUserIndex;
    _currentStoryIndex = 0;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    // Start animation
    _animationController.forward();
    
    // Mark story as viewed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markCurrentStoryAsViewed();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  UserStories get _currentUserStories => widget.userStoriesList[_currentUserIndex];
  Story get _currentStory => _currentUserStories.stories[_currentStoryIndex];
  bool get _isCurrentUserOwner => _currentUserStories.userId == Provider.of<StoryProvider>(context, listen: false).currentUserId;

  void _markCurrentStoryAsViewed() {
    Provider.of<StoryProvider>(context, listen: false).markStoryAsViewed(_currentStory.id);
  }

  void _nextStory() {
    if (_currentStoryIndex < _currentUserStories.stories.length - 1) {
      // Next story of current user
      setState(() {
        _currentStoryIndex++;
      });
      _animationController.reset();
      _animationController.forward();
      _markCurrentStoryAsViewed();
    } else if (_currentUserIndex < widget.userStoriesList.length - 1) {
      // Next user's stories
      setState(() {
        _currentUserIndex++;
        _currentStoryIndex = 0;
      });
      _animationController.reset();
      _animationController.forward();
      _markCurrentStoryAsViewed();
    } else {
      // End of all stories
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentStoryIndex > 0) {
      // Previous story of current user
      setState(() {
        _currentStoryIndex--;
      });
      _animationController.reset();
      _animationController.forward();
    } else if (_currentUserIndex > 0) {
      // Previous user's stories
      setState(() {
        _currentUserIndex--;
        _currentStoryIndex = widget.userStoriesList[_currentUserIndex].stories.length - 1;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _animationController.stop();
      } else {
        _animationController.forward();
      }
    });
  }

  void _showAddStoryOptions() {
    final StoryProvider storyProvider = Provider.of<StoryProvider>(context, listen: false);
    
    setState(() {
      _isPaused = true;
      _animationController.stop();
      _isShowingUserOptions = true;
    });
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_photo_alternate, color: Colors.white),
              title: const Text('Add New Story', style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStoryScreen(
                      onStoryAdded: () {
                        storyProvider.fetchStories();
                      },
                    ),
                  ),
                );
                
                setState(() {
                  _isPaused = false;
                  _isShowingUserOptions = false;
                  _animationController.forward();
                });
              },
            ),
            if (_isCurrentUserOwner)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Story', 
                  style: TextStyle(color: Colors.red)),
                onTap: () async {
                  Navigator.pop(context);
                  
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Story'),
                      content: const Text('Are you sure you want to delete this story?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirmed == true) {
                    final storyId = _currentStory.id;
                    final success = await storyProvider.deleteStory(storyId);
                    
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Story deleted successfully')),
                      );
                      
                      if (storyProvider.currentUserHasStory()) {
                        // Reload the screen with updated stories
                        _nextStory();
                      } else {
                        // Exit if no more stories
                        if (!mounted) return;
                        Navigator.pop(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(storyProvider.error ?? 'Failed to delete story')),
                      );
                    }
                  }
                  
                  setState(() {
                    _isPaused = false;
                    _isShowingUserOptions = false;
                    _animationController.forward();
                  });
                },
              ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.white),
              title: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _isPaused = false;
                  _isShowingUserOptions = false;
                  _animationController.forward();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String storyImageUrl = 'https://posterbnaobackend.onrender.com/${_currentStory.images[0]}';
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          if (_isShowingUserOptions) return;
          
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.globalPosition.dx;
          
          if (tapPosition < screenWidth * 0.3) {
            _previousStory();
          } else if (tapPosition > screenWidth * 0.7) {
            _nextStory();
          } else {
            _togglePause();
          }
        },
        onLongPress: () {
          if (_isCurrentUserOwner) {
            _showAddStoryOptions();
          }
        },
        child: Stack(
          children: [
            // Story content
            Positioned.fill(
              child: Image.network(
                storyImageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            
            // Progress indicator
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(
                  _currentUserStories.stories.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: LinearProgressIndicator(
                        value: index < _currentStoryIndex
                            ? 1.0
                            : index > _currentStoryIndex
                                ? 0.0
                                : _animationController.value,
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // User info
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  // User avatar
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                      image: _currentUserStories.userAvatar.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(_currentUserStories.userAvatar),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _currentUserStories.userAvatar.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  // Username and timestamp
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentUserStories.username.isNotEmpty
                            ? _currentUserStories.username
                            : _isCurrentUserOwner ? 'Your Story' : 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_timeAgo(_currentStory.createdAt)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // More options for current user
                  if (_isCurrentUserOwner)
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: _showAddStoryOptions,
                    ),
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Caption
            if (_currentStory.caption.isNotEmpty)
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _currentStory.caption,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            
            // Navigation arrows
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - previous
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: _currentUserIndex > 0 || _currentStoryIndex > 0
                        ? const Opacity(
                            opacity: 0.0,
                            child: Icon(Icons.arrow_back_ios, color: Colors.white),
                          )
                        : null,
                  ),
                  
                  // Right side - next
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: _currentUserIndex < widget.userStoriesList.length - 1 ||
                            _currentStoryIndex < _currentUserStories.stories.length - 1
                        ? const Opacity(
                            opacity: 0.0,
                            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

