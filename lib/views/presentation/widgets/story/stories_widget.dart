// import 'package:company_project/views/presentation/widgets/story/add_story.dart';
// import 'package:company_project/views/presentation/widgets/story/story_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:company_project/providers/story_provider.dart';
// import 'package:company_project/models/story_model.dart';

// class StoriesWidget extends StatefulWidget {
//   final String currentUserId;

//   const StoriesWidget({
//     Key? key,
//     required this.currentUserId,
//   }) : super(key: key);

//   @override
//   State<StoriesWidget> createState() => _StoriesWidgetState();
// }

// class _StoriesWidgetState extends State<StoriesWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // Set the current user ID in the provider
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final storyProvider = Provider.of<StoryProvider>(context, listen: false);
//       storyProvider.setCurrentUserId(widget.currentUserId);
//       storyProvider.fetchStories();
//     });
//   }

//   // Open the add story screen
//   void _openAddStory() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddStoryWidget(
//           userId: widget.currentUserId,
//           onStoryAdded: () {
//             // Refresh stories after adding
//             Provider.of<StoryProvider>(context, listen: false).fetchStories();
//           },
//         ),
//       ),
//     );
//   }

//   // Open the story viewer
//   void _openStoryViewer(List<Story> allStories, int userIndex) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StoryViewerScreen(
//           stories: allStories,
//           viewIndex: userIndex,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StoryProvider>(
//       builder: (context, storyProvider, child) {
//         // Check if data is still loading
//         if (storyProvider.isLoading) {
//           return SizedBox(
//             height: 120,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         // Group stories by user
//         final List<UserStories> userStoriesList = groupStoriesByUser(storyProvider.stories);
        
//         // Find current user's stories
//         final int currentUserIndex = userStoriesList.indexWhere((u) => u.userId == widget.currentUserId);
//         final bool hasActiveStory = currentUserIndex != -1;

//         return SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: userStoriesList.length + (hasActiveStory ? 0 : 1), // Add 1 for "Add Story" if no user story
//             itemBuilder: (context, index) {
//               // First position shows either "Add Story" or current user's stories based on hasActiveStory
//               if (!hasActiveStory && index == 0) {
//                 // Show "Add Story" button
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   child: GestureDetector(
//                     onTap: _openAddStory,
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 16),
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.grey[300],
//                               child: const Icon(
//                                 Icons.add,
//                                 size: 32,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         const Text(
//                           'Add Story',
//                           style: TextStyle(color: Colors.black),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               } else {
//                 // We need to adjust the index if we have the "Add Story" button
//                 final userIndex = !hasActiveStory ? index - 1 : index;
//                 final userStories = userStoriesList[userIndex];
                
//                 // Determine if this is the current user's story
//                 final bool isCurrentUser = userStories.userId == widget.currentUserId;
                
//                 // Get the first story image to display as thumbnail
//                 final String thumbnailUrl = 'https://posterbnaobackend.onrender.com/${userStories.stories.first.images[0]}';
                
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   child: GestureDetector(
//                     onTap: () => _openStoryViewer(storyProvider.stories, userIndex),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 16),
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: const Color(0xFF6C4EF9),
//                               width: 2,
//                             ),
//                           ),
//                           child: CircleAvatar(
//                             radius: 30,
//                             backgroundImage: NetworkImage(
//                               thumbnailUrl,
//                             ),
//                             onBackgroundImageError: (exception, stackTrace) {
//                               print('Error loading story image: $exception');
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           isCurrentUser ? 'Your Story' : 'Story',
//                           style: const TextStyle(color: Colors.black),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// // Helper functions
// class UserStories {
//   final String userId;
//   final List<Story> stories;

//   UserStories({required this.userId, required this.stories});
// }

// List<UserStories> groupStoriesByUser(List<Story> stories) {
//   final Map<String, List<Story>> grouped = {};

//   for (var story in stories) {
//     if (!grouped.containsKey(story.userId)) {
//       grouped[story.userId] = [];
//     }
//     grouped[story.userId]!.add(story);
//   }

//   return grouped.entries
//       .map((entry) => UserStories(userId: entry.key, stories: entry.value))
//       .toList();
// }





// import 'package:company_project/models/story_model.dart';
// import 'package:company_project/providers/story_provider.dart';
// import 'package:company_project/views/presentation/widgets/story/add_story.dart';
// import 'package:company_project/views/presentation/widgets/story/story_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';


// class StoriesWidget extends StatelessWidget {
//   const StoriesWidget({Key? key}) : super(key: key);

//   void _openAddStory(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddStoryScreen(
//           onStoryAdded: () {
//             // Refresh stories after adding
//             Provider.of<StoryProvider>(context, listen: false).fetchStories();
//           },
//         ),
//       ),
//     );
//   }

//   void _openStoryViewer(BuildContext context, List<UserStories> userStoriesList, int initialUserIndex) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StoryViewerScreen(
//           userStoriesList: userStoriesList,
//           initialUserIndex: initialUserIndex,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StoryProvider>(
//       builder: (context, storyProvider, child) {
//         if (storyProvider.isLoading) {
//           return const SizedBox(
//             height: 110,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final userStoriesList = storyProvider.getStoriesForDisplay();
//         final bool currentUserHasStory = storyProvider.currentUserHasStory();
//         final String? currentUserImage = storyProvider.currentUserImage;

//         return Container(
//           height: 110,
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 6,
//                 offset: const Offset(2, 0),
//               ),
//             ],
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             itemCount: userStoriesList.length + (currentUserHasStory ? 0 : 1),
//             itemBuilder: (context, index) {
//               // First position shows "Add Story" if user has no story
//               if (!currentUserHasStory && index == 0) {
//                 return _buildAddStoryItem(context, currentUserImage);
//               }
              
//               // Adjust index for user stories list if "Add Story" is shown
//               final int adjustedIndex = currentUserHasStory ? index : index - 1;
//               final UserStories userStories = userStoriesList[adjustedIndex];
//               final bool isCurrentUser = userStories.userId == storyProvider.currentUserId;
              
//               return _buildStoryItem(
//                 context, 
//                 userStories, 
//                 isCurrentUser,
//                 () => _openStoryViewer(context, userStoriesList, adjustedIndex),
//                 userStories.hasUnviewedStories,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddStoryItem(BuildContext context, String? userProfileImage) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//       child: GestureDetector(
//         onTap: () => _openAddStory(context),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 // User profile image
//                 Container(
//                   width: 65,
//                   height: 65,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.grey[300],
//                     image: userProfileImage != null
//                         ? DecorationImage(
//                             image: NetworkImage(userProfileImage),
//                             fit: BoxFit.cover,
//                           )
//                         : null,
//                   ),
//                   child: userProfileImage == null
//                       ? const Icon(Icons.person, size: 35, color: Colors.white)
//                       : null,
//                 ),
//                 // Plus icon overlay
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 2),
//                     ),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               'Your Story',
//               style: TextStyle(fontSize: 12,color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStoryItem(
//     BuildContext context, 
//     UserStories userStories, 
//     bool isCurrentUser,
//     VoidCallback onTap,
//     bool hasUnviewedStories,
//   ) {
//     // Get first story image for thumbnail
//     final String thumbnailUrl = userStories.stories.isNotEmpty && userStories.stories.first.images.isNotEmpty
//         ? 'https://posterbnaobackend.onrender.com/${userStories.stories.first.images[0]}'
//         : '';

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           children: [
//             Container(
//               width: 68,
//               height: 68,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: hasUnviewedStories 
//                     ? const LinearGradient(
//                         colors: [Colors.purple, Colors.orange, Colors.pink],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       )
//                     : null,
//                 border: !hasUnviewedStories 
//                     ? Border.all(color: Colors.grey, width: 2) 
//                     : null,
//               ),
//               padding: const EdgeInsets.all(2), // Border width
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[300],
//                   border: Border.all(color: Colors.white, width: 2),
//                   image: thumbnailUrl.isNotEmpty
//                       ? DecorationImage(
//                           image: NetworkImage(thumbnailUrl),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               isCurrentUser ? 'Your Story' : userStories.username.isNotEmpty ? userStories.username : 'Story',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: hasUnviewedStories ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:company_project/models/story_model.dart';
import 'package:company_project/providers/story_provider.dart';
import 'package:company_project/views/presentation/widgets/story/add_story.dart';
import 'package:company_project/views/presentation/widgets/story/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({Key? key}) : super(key: key);

  void _openAddStory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStoryScreen(
          onStoryAdded: () {
            // Refresh stories after adding
            Provider.of<StoryProvider>(context, listen: false).fetchStories();
          },
        ),
      ),
    );
  }

  void _openStoryViewer(BuildContext context, List<UserStories> userStoriesList, int initialUserIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewerScreen(
          userStoriesList: userStoriesList,
          initialUserIndex: initialUserIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, child) {
        if (storyProvider.isLoading) {
          return _buildSkeletonLoading();
        }

        final userStoriesList = storyProvider.getStoriesForDisplay();
        final bool currentUserHasStory = storyProvider.currentUserHasStory();
        final String? currentUserImage = storyProvider.currentUserImage;

        return Container(
          height: 110,
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       blurRadius: 6,
          //       offset: const Offset(2, 0),
          //     ),
          //   ],
          // ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: userStoriesList.length + (currentUserHasStory ? 0 : 1),
            itemBuilder: (context, index) {
              // First position shows "Add Story" if user has no story
              if (!currentUserHasStory && index == 0) {
                return _buildAddStoryItem(context, currentUserImage);
              }
              
              // Adjust index for user stories list if "Add Story" is shown
              final int adjustedIndex = currentUserHasStory ? index : index - 1;
              final UserStories userStories = userStoriesList[adjustedIndex];
              final bool isCurrentUser = userStories.userId == storyProvider.currentUserId;
              
              return _buildStoryItem(
                context, 
                userStories, 
                isCurrentUser,
                () => _openStoryViewer(context, userStoriesList, adjustedIndex),
                userStories.hasUnviewedStories,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoading() {
    return SizedBox(
      height: 110,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: 5, // Show 5 skeleton items
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  // Skeleton circle for avatar
                  Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Skeleton rectangle for text
                  Container(
                    width: 50,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddStoryItem(BuildContext context, String? userProfileImage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: GestureDetector(
        onTap: () => _openAddStory(context),
        child: Column(
          children: [
            Stack(
              children: [
                // User profile image
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image: userProfileImage != null
                        ? DecorationImage(
                            image: NetworkImage(userProfileImage),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: userProfileImage == null
                      ? const Icon(Icons.person, size: 35, color: Colors.white)
                      : null,
                ),
                // Plus icon overlay
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Your Story',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryItem(
    BuildContext context, 
    UserStories userStories, 
    bool isCurrentUser,
    VoidCallback onTap,
    bool hasUnviewedStories,
  ) {
    // Get first story image for thumbnail
    final String thumbnailUrl = userStories.stories.isNotEmpty && userStories.stories.first.images.isNotEmpty
        ? 'https://posterbnaobackend.onrender.com/${userStories.stories.first.images[0]}'
        : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hasUnviewedStories 
                    ? const LinearGradient(
                        colors: [Colors.purple, Colors.orange, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                border: !hasUnviewedStories 
                    ? Border.all(color: Colors.grey, width: 2) 
                    : null,
              ),
              padding: const EdgeInsets.all(2), // Border width
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.white, width: 2),
                  image: thumbnailUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(thumbnailUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isCurrentUser ? 'Your Story' : userStories.username.isNotEmpty ? userStories.username : 'Story',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: hasUnviewedStories ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}