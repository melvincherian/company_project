import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/models/story_model.dart';

class StoriesWidget extends StatefulWidget {
  final String currentUserId;

  const StoriesWidget({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  @override
  void initState() {
    super.initState();
    // Set the current user ID in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final storyProvider = Provider.of<StoryProvider>(context, listen: false);
      storyProvider.setCurrentUserId(widget.currentUserId);
      storyProvider.fetchStories();
    });
  }

  // Open the add story screen
  void _openAddStory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStoryWidget(
          userId: widget.currentUserId,
          onStoryAdded: () {
            // Refresh stories after adding
            Provider.of<StoryProvider>(context, listen: false).fetchStories();
          },
        ),
      ),
    );
  }

  // Open the story viewer
  void _openStoryViewer(List<Story> allStories, int userIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewerScreen(
          stories: allStories,
          initialIndex: userIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, child) {
        // Check if data is still loading
        if (storyProvider.isLoading) {
          return SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // Group stories by user
        final List<UserStories> userStoriesList = groupStoriesByUser(storyProvider.stories);
        
        // Find current user's stories
        final int currentUserIndex = userStoriesList.indexWhere((u) => u.userId == widget.currentUserId);
        final bool hasActiveStory = currentUserIndex != -1;

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: userStoriesList.length + (hasActiveStory ? 0 : 1), // Add 1 for "Add Story" if no user story
            itemBuilder: (context, index) {
              // First position shows either "Add Story" or current user's stories based on hasActiveStory
              if (!hasActiveStory && index == 0) {
                // Show "Add Story" button
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GestureDetector(
                    onTap: _openAddStory,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.add,
                                size: 32,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Add Story',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                // We need to adjust the index if we have the "Add Story" button
                final userIndex = !hasActiveStory ? index - 1 : index;
                final userStories = userStoriesList[userIndex];
                
                // Determine if this is the current user's story
                final bool isCurrentUser = userStories.userId == widget.currentUserId;
                
                // Get the first story image to display as thumbnail
                final String thumbnailUrl = 'https://posterbnaobackend.onrender.com/${userStories.stories.first.images[0]}';
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GestureDetector(
                    onTap: () => _openStoryViewer(storyProvider.stories, userIndex),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF6C4EF9),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              thumbnailUrl,
                            ),
                            onBackgroundImageError: (exception, stackTrace) {
                              print('Error loading story image: $exception');
                            },
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isCurrentUser ? 'Your Story' : 'Story',
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

// Helper functions
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