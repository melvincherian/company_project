// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)), 
        backgroundColor: Colors.white, 
        iconTheme: const IconThemeData(color: Colors.black), 
        elevation: 0, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>const RewardScreen()));
              },
              child: _buildSettingsItem(
                context,
                'Notifications',
                _notificationsEnabled,
                (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                const Icon(Icons.notifications), 
              ),
            ),
            _buildSettingsItem(
              context,
              'Dark Mode',
              _darkModeEnabled,
              (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
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
        color: Colors.white,
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
