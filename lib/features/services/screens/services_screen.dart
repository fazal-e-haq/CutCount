import 'package:cut_count/core/widgets/app_ui.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppUi(
      topCard: TopCard(
          padding: EdgeInsets.all(16),
          child: Text('data')),
      children: [],
    );
  }
}

// import 'package:flutter/material.dart';
//
// import 'package:cut_count/core/widgets/app_ui.dart';
//
// class ServicesScreen extends StatelessWidget {
//   const ServicesScreen({super.key});
//
//   static const List<_ServiceItem> _services = [
//     _ServiceItem(
//       name: 'Fade',
//       price: 'PKR 700',
//       subtitle: 'Most used service',
//       icon: Icons.content_cut_rounded,
//       color: Color(0xFFE95401),
//     ),
//     _ServiceItem(
//       name: 'Classic cut',
//       price: 'PKR 500',
//       subtitle: 'Standard haircut',
//       icon: Icons.cut_rounded,
//       color: Color(0xFF3949AB),
//     ),
//     _ServiceItem(
//       name: 'Beard trim',
//       price: 'PKR 250',
//       subtitle: 'Quick grooming',
//       icon: Icons.face_rounded,
//       color: Color(0xFF00897B),
//     ),
//     _ServiceItem(
//       name: 'Shave',
//       price: 'PKR 150',
//       subtitle: 'Clean shave',
//       icon: Icons.spa_rounded,
//       color: Color(0xFF7B1FA2),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final primary = Theme.of(context).colorScheme.primary;
//
//     return AppPage(
//       title: 'Services',
//       subtitle: 'Manage prices and shortcuts for instant cut entry.',
//       trailing: SolidIconButton(
//         icon: Icons.add_rounded,
//         tooltip: 'Add service',
//         onPressed: () {},
//       ),
//       children: [
//         FadeSlideIn(
//           child: AppCard(
//             color: primary,
//             borderColor: primary,
//             padding: const EdgeInsets.all(18),
//             child: const _ServiceOverview(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Active services'),
//         ..._services.map(
//           (service) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: _ServiceCard(service: service),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ServiceOverview extends StatelessWidget {
//   const _ServiceOverview();
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
//             Icons.storefront_rounded,
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
//                 '4 services ready',
//                 style: textTheme.headlineSmall?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 'Use this screen for add, edit, and delete flows later.',
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
// class _ServiceCard extends StatelessWidget {
//   const _ServiceCard({required this.service});
//
//   final _ServiceItem service;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//
//     return AppCard(
//       padding: const EdgeInsets.all(14),
//       child: Row(
//         children: [
//           SolidIconBox(icon: service.icon, color: service.color, size: 42),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   service.name,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: textTheme.bodyLarge?.copyWith(
//                     color: colorScheme.onSurface,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   service.subtitle,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: textTheme.bodySmall?.copyWith(
//                     color: colorScheme.onSurface.withAlpha(145),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 StatusPill(label: service.price, color: service.color),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Column(
//             children: [
//               _SmallActionButton(
//                 icon: Icons.edit_rounded,
//                 tooltip: 'Edit service',
//                 onPressed: () {},
//               ),
//               const SizedBox(height: 8),
//               _SmallActionButton(
//                 icon: Icons.delete_outline_rounded,
//                 tooltip: 'Delete service',
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SmallActionButton extends StatelessWidget {
//   const _SmallActionButton({
//     required this.icon,
//     required this.tooltip,
//     required this.onPressed,
//   });
//
//   final IconData icon;
//   final String tooltip;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return IconButton.outlined(
//       tooltip: tooltip,
//       iconSize: 18,
//       visualDensity: VisualDensity.compact,
//       style: IconButton.styleFrom(
//         fixedSize: const Size(36, 36),
//         foregroundColor: colorScheme.onSurface,
//         side: BorderSide(color: colorScheme.outline.withAlpha(80)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       onPressed: onPressed,
//       icon: Icon(icon),
//     );
//   }
// }
//
// class _ServiceItem {
//   const _ServiceItem({
//     required this.name,
//     required this.price,
//     required this.subtitle,
//     required this.icon,
//     required this.color,
//   });
//
//   final String name;
//   final String price;
//   final String subtitle;
//   final IconData icon;
//   final Color color;
// }
