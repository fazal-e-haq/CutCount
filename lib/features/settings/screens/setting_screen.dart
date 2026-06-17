 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16,vertical: 8),
          child: ListView(
            scrollDirection: .vertical,

            children: [
              ListTile(
                leading: Icon(Icons.dark_mode, size: 35),
                title: Text(
                  'Dark mode',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              trailing: Switch.adaptive(value: context.watch<ThemeProvider>().isdark, onChanged: (value) {
                context.read<ThemeProvider>().changeTheme(value);
              },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
