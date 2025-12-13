import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.dark_mode_outlined), title: Text('حالت تاریک'), subtitle: Text('خودکار / دستی')),
          Divider(),
          ListTile(leading: Icon(Icons.language_outlined), title: Text('زبان'), subtitle: Text('فارسی')),
          Divider(),
          ListTile(leading: Icon(Icons.info_outline), title: Text('درباره برنامه')),
        ],
      ),
    );
  }
}
