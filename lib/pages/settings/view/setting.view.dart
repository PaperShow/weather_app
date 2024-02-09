import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/settings/provider/theme.provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeNotifier, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Light'),
                      const SizedBox(width: 8.0),
                      Switch(
                        value: themeNotifier.isDark,
                        onChanged: (value) =>
                            context.read<ThemeProvider>().toggleTheme(),
                      ),
                      const Text('Dark'),
                    ],
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
