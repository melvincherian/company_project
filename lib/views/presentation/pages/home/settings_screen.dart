import 'package:company_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
 // Import ThemeProvider

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    bool _notificationsEnabled = true; // Still local, unless you plan to manage it globally

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSettingsItem(
              context,
              'Notifications',
              _notificationsEnabled,
              (value) {},
              const Icon(Icons.notifications),
            ),
            _buildSettingsItem(
              context,
              'Dark Mode',
              themeProvider.isDarkMode,
              (value) => themeProvider.toggleTheme(value),
              const Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
    Icon icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            FlutterSwitch(
              value: value,
              onToggle: onChanged,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              showOnOff: false,
            ),
          ],
        ),
      ),
    );
  }
}
