import 'package:cut_count/core/widgets/app_ui.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppUi(
      topCard: TopCard(
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.fromLTRB(16, 10, 30, 10),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Text('data'),
      ),
      children: [],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'package:cut_count/core/widgets/app_ui.dart';
// import 'package:cut_count/features/settings/providers/theme_provider.dart';
//
// class SettingScreen extends StatelessWidget {
//   const SettingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return AppPage(
//       title: 'Settings',
//       subtitle: 'Control access, appearance, and app preferences.',
//       trailing: SolidIconButton(
//         icon: Icons.lock_outline_rounded,
//         tooltip: 'PIN settings',
//         onPressed: () {},
//       ),
//       children: [
//         FadeSlideIn(
//           child: AppCard(
//             color: colorScheme.primary,
//             borderColor: colorScheme.primary,
//             padding: const EdgeInsets.all(18),
//             child: const _SettingsOverview(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Security'),
//         _SettingsTile(
//           icon: Icons.pin_rounded,
//           title: '4-digit PIN',
//           subtitle: 'Require PIN when the app opens',
//           accent: const Color(0xFFE95401),
//           trailing: StatusPill(label: 'Setup', color: colorScheme.primary),
//           onTap: () {},
//         ),
//         const SizedBox(height: 12),
//         _SettingsTile(
//           icon: Icons.fingerprint_rounded,
//           title: 'Biometric login',
//           subtitle: 'Future premium-ready login option',
//           accent: const Color(0xFF3949AB),
//           trailing: const StatusPill(label: 'Future', color: Color(0xFF3949AB)),
//           onTap: () {},
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Preferences'),
//         _SettingsTile(
//           icon: Icons.dark_mode_rounded,
//           title: 'Dark mode',
//           subtitle: 'Switch between light and dark UI',
//           accent: const Color(0xFF7B1FA2),
//           trailing: Switch.adaptive(
//             value: themeProvider.isdark,
//             onChanged: themeProvider.changeTheme,
//           ),
//         ),
//         const SizedBox(height: 12),
//         _SettingsTile(
//           icon: Icons.currency_exchange_rounded,
//           title: 'Currency',
//           subtitle: 'Pakistan Rupee',
//           accent: const Color(0xFF00897B),
//           trailing: const StatusPill(label: 'PKR', color: Color(0xFF00897B)),
//           onTap: () {},
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Storage and plan'),
//         _SettingsTile(
//           icon: Icons.storage_rounded,
//           title: 'Offline data',
//           subtitle: '6-9 months local history on free plan',
//           accent: const Color(0xFFE95401),
//           trailing: const Icon(Icons.chevron_right_rounded),
//           onTap: () {},
//         ),
//         const SizedBox(height: 12),
//         _SettingsTile(
//           icon: Icons.workspace_premium_rounded,
//           title: 'Premium',
//           subtitle: 'Backup, reports, analytics, and long history',
//           accent: const Color(0xFF7B1FA2),
//           trailing: const StatusPill(label: 'Soon', color: Color(0xFF7B1FA2)),
//           onTap: () {},
//         ),
//       ],
//     );
//   }
// }
//
// class _SettingsOverview extends StatelessWidget {
//   const _SettingsOverview();
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return Row(
//       children: [
//         Container(
//           width: 54,
//           height: 54,
//           decoration: BoxDecoration(
//             color: Colors.white.withAlpha(42),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Icon(
//             Icons.offline_bolt_rounded,
//             color: Colors.white,
//             size: 28,
//           ),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Offline-first setup',
//                 style: textTheme.headlineSmall?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 'Core app settings are ready for your storage and auth logic.',
//                 style: textTheme.bodyMedium?.copyWith(
//                   color: Colors.white.withAlpha(215),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _SettingsTile extends StatelessWidget {
//   const _SettingsTile({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.accent,
//     required this.trailing,
//     this.onTap,
//   });
//
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color accent;
//   final Widget trailing;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppListRow(
//       icon: icon,
//       title: title,
//       subtitle: subtitle,
//       accent: accent,
//       trailing: trailing,
//       onTap: onTap,
//     );
//   }
// }
