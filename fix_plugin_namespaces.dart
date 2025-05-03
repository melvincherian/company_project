import 'dart:io';

void main() async {
  print('Starting to fix plugin namespaces...');
  
  // Find where the plugins are stored in the .pub-cache directory
  // On Windows, it's typically in %LOCALAPPDATA%\Pub\Cache or %APPDATA%\.pub-cache
  String? pubCachePath;
  
  // Check common locations for the pub cache
  List<String> possibleLocations = [
    '${Platform.environment['LOCALAPPDATA']}\\Pub\\Cache',
    '${Platform.environment['APPDATA']}\\.pub-cache',
    '${Platform.environment['HOME']}\\.pub-cache',
  ];
  
  for (String location in possibleLocations) {
    if (location != 'null' && Directory(location).existsSync()) {
      pubCachePath = location;
      print('Found pub cache at: $pubCachePath');
      break;
    }
  }
  
  // If we couldn't find the pub cache, look in .flutter-plugins-dependencies
  if (pubCachePath == null) {
    print('Could not find pub cache in common locations, trying alternative method...');
    
    // Try to read the .flutter-plugins-dependencies file to find plugin paths
    final pluginsFile = File('.flutter-plugins-dependencies');
    if (pluginsFile.existsSync()) {
      print('Found .flutter-plugins-dependencies file, checking for plugin locations...');
      try {
        // Looking for plugin paths directly in the project
        List<FileSystemEntity> entities = Directory('.').listSync(recursive: true);
        
        // Look for all build.gradle files in plugin directories
        for (var entity in entities) {
          if (entity.path.contains('image_gallery_saver') && 
              entity.path.endsWith('build.gradle')) {
            print('Found build.gradle at: ${entity.path}');
            await fixNamespaceInFile(File(entity.path), 'image_gallery_saver');
          }
        }
      } catch (e) {
        print('Error reading .flutter-plugins-dependencies: $e');
      }
    }
  } else {
    // If we found the pub cache, look for image_gallery_saver plugin
    final pluginsDir = Directory('$pubCachePath\\hosted\\pub.dev');
    
    if (pluginsDir.existsSync()) {
      print('Searching for image_gallery_saver plugin...');
      
      try {
        List<FileSystemEntity> plugins = pluginsDir.listSync();
        
        for (var plugin in plugins) {
          if (plugin.path.contains('image_gallery_saver')) {
            final gradlePath = '${plugin.path}\\android\\build.gradle';
            final gradleFile = File(gradlePath);
            
            if (gradleFile.existsSync()) {
              print('Found build.gradle at: $gradlePath');
              await fixNamespaceInFile(gradleFile, 'image_gallery_saver');
            }
          }
        }
      } catch (e) {
        print('Error searching for plugins: $e');
      }
    }
  }
  
  // Alternatively, check directly in the project's .pub-cache folder
  final projectPubCache = Directory('.pub-cache');
  if (projectPubCache.existsSync()) {
    print('Checking project-level .pub-cache...');
    // Similar process to search for plugins...
  }
  
  print('\nAttempting direct modification of plugin in your project...');
  print('Looking in build directory...');
  
  try {
    // Try looking directly in the build folder
    final buildDir = Directory('build');
    if (buildDir.existsSync()) {
      await searchAndFixInDirectory(buildDir, 'image_gallery_saver');
    }
  } catch (e) {
    print('Error searching build directory: $e');
  }
  
  print('\nFinished fixing plugin namespaces.');
  print('\nIf you continue to have issues, you may need to manually modify the plugin\'s build.gradle file.');
  print('Instructions:');
  print('1. Find the image_gallery_saver plugin\'s build.gradle file');
  print('2. Open it in a text editor');
  print('3. Add this line inside the android {} block:');
  print('   namespace "com.example.imagegallerysaver"');
}

Future<void> searchAndFixInDirectory(Directory dir, String pluginName) async {
  try {
    List<FileSystemEntity> entities = dir.listSync(recursive: false);
    
    for (var entity in entities) {
      if (entity is Directory) {
        if (entity.path.contains(pluginName)) {
          // Found the plugin directory
          final gradlePath = '${entity.path}\\android\\build.gradle';
          final gradleFile = File(gradlePath);
          
          if (gradleFile.existsSync()) {
            print('Found build.gradle at: $gradlePath');
            await fixNamespaceInFile(gradleFile, pluginName);
          }
        } else {
          // Continue searching recursively, but avoid certain directories
          if (!entity.path.contains('.dart_tool') && 
              !entity.path.contains('.idea') && 
              !entity.path.contains('ios') &&
              !entity.path.contains('web')) {
            await searchAndFixInDirectory(entity, pluginName);
          }
        }
      }
    }
  } catch (e) {
    // Silently continue if we can't access a directory
  }
}

Future<void> fixNamespaceInFile(File gradleFile, String pluginName) async {
  try {
    String content = await gradleFile.readAsString();
    
    // Skip if namespace is already defined
    if (content.contains('namespace')) {
      print('File already has namespace defined.');
      return;
    }
    
    // Add namespace to android block
    final sanitizedName = pluginName.replaceAll('-', '').replaceAll('_', '');
    content = content.replaceFirst(
      RegExp(r'android\s*\{'),
      'android {\n    namespace "com.example.$sanitizedName"'
    );
    
    await gradleFile.writeAsString(content);
    print('Successfully added namespace to ${gradleFile.path}');
  } catch (e) {
    print('Error modifying file: $e');
  }
}