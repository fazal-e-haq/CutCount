import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('Settings'),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(title: 'Preferences'),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: [
                    CustomListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Theme toggle'),
                      subtitle: const Text('Enable dark mode'),
                      trailing: Switch(
                        value: settings.darkModeEnabled,
                        onChanged: settings.toggleTheme,
                      ),
                    ),

                    CustomListTile(
                      leading: const Icon(Icons.notifications_outlined),
                      title: const Text('Notifications'),
                      subtitle: const Text('Receive reminders and updates'),
                      trailing: Switch(
                        value: settings.notificationsEnabled,
                        onChanged: settings.toggleNotifications,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              _SectionTitle(title: 'Currency'),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: AppCurrency.values.map((currency) {
                    final label = switch (currency) {
                      AppCurrency.pkr => 'PKR',
                      AppCurrency.usd => 'USD',
                      AppCurrency.inr => 'INR',
                      AppCurrency.gbp => 'GBP',
                      AppCurrency.eur => 'EUR',
                    };
                    return CustomListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(label),
                      trailing: ChoiceChip(
                        label: const Text('Selected'),
                        selected: settings.currency == currency,
                        onSelected: (_) => settings.setCurrency(currency),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              _SectionTitle(title: 'Future features'),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: const [
                    CustomListTile(
                      leading: Icon(Icons.fingerprint),
                      title: Text('Biometric unlock'),
                      subtitle: Text('Faster secure sign-in for the owner'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.cloud_sync_outlined),
                      title: Text('Cloud backup'),
                      subtitle: Text('Keep data safe across devices'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.print_outlined),
                      title: Text('Receipt printer'),
                      subtitle: Text('Connect a printer for customer bills'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.analytics_outlined),
                      title: Text('Advanced analytics'),
                      subtitle: Text('Weekly trends and performance insights'),
                      trailing: Icon(Icons.chevron_right),
                    ),

                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.language_outlined),
                      title: Text('Multi-language support'),
                      subtitle: Text('Make the app easier for more users'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              _SectionTitle(title: 'How to use'),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: const [
                    CustomListTile(
                      leading: Icon(Icons.looks_one_outlined),
                      title: Text('Open Dashboard'),
                      subtitle: Text('Check today’s cuts, amount, and services'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.looks_two_outlined),
                      title: Text('Add services'),
                      subtitle: Text('Save haircut and shave prices in Services'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.looks_3_outlined),
                      title: Text('Review history'),
                      subtitle: Text('Open monthly or today history from History'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 1),
                    CustomListTile(
                      leading: Icon(Icons.looks_4_outlined),
                      title: Text('Adjust settings'),
                      subtitle: Text('Change theme, currency, biometric, and alerts'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              _SectionTitle(title: 'Legal & support'),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: const [
                    CustomListTile(
                      leading: Icon(Icons.privacy_tip_outlined),
                      title: Text('Privacy policy'),
                      trailing: Icon(Icons.chevron_right),
                    ),

                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
