import 'package:flutter/material.dart';

import 'package:cut_count/core/widgets/app_ui.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<_DashboardMetric> _metrics = [
    _DashboardMetric(
      label: 'Today cuts',
      value: '18',
      footer: '+4 from yesterday',
      icon: Icons.content_cut_rounded,
      color: Color(0xFFE95401),
    ),
    _DashboardMetric(
      label: 'Today earnings',
      value: 'PKR 9.4k',
      footer: 'Average PKR 522',
      icon: Icons.payments_rounded,
      color: Color(0xFF00897B),
    ),
    _DashboardMetric(
      label: 'Monthly cuts',
      value: '286',
      footer: '72% of target',
      icon: Icons.calendar_month_rounded,
      color: Color(0xFF3949AB),
    ),
    _DashboardMetric(
      label: 'Monthly earnings',
      value: 'PKR 168k',
      footer: 'Strong month',
      icon: Icons.bar_chart_rounded,
      color: Color(0xFF7B1FA2),
    ),
  ];

  static const List<_ServiceShortcut> _shortcuts = [
    _ServiceShortcut('Fade', 'PKR 700', Icons.content_cut_rounded),
    _ServiceShortcut('Beard trim', 'PKR 250', Icons.face_rounded),
    _ServiceShortcut('Shave', 'PKR 150', Icons.spa_rounded),
    _ServiceShortcut('Hair wash', 'PKR 300', Icons.water_drop_rounded),
  ];

  static const List<_RecentCut> _recentCuts = [
    _RecentCut('Fade', '11:42 AM', 'PKR 700', Color(0xFFE95401)),
    _RecentCut('Beard trim', '10:58 AM', 'PKR 250', Color(0xFF00897B)),
    _RecentCut('Classic cut', '10:21 AM', 'PKR 500', Color(0xFF3949AB)),
  ];

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return AppPage(
      title: 'Dashboard',
      subtitle: 'Track cuts, earnings, and quick actions for today.',
      trailing: SolidIconButton(
        icon: Icons.add_rounded,
        tooltip: 'Add cut',
        onPressed: () {},
      ),
      children: [
        FadeSlideIn(
          child: AppCard(
            color: primary,
            borderColor: primary,
            padding: const EdgeInsets.all(18),
            child: const _TodaySummary(),
          ),
        ),
        const SizedBox(height: 18),
        FadeSlideIn(
          duration: const Duration(milliseconds: 520),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.18,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _metrics
                .map(
                  (metric) => MetricCard(
                    label: metric.label,
                    value: metric.value,
                    icon: metric.icon,
                    accent: metric.color,
                    footer: metric.footer,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 24),
        SectionHeader(
          title: 'Service shortcuts',
          actionLabel: 'Manage',
          onActionTap: () {},
        ),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _shortcuts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final shortcut = _shortcuts[index];
              return _ServiceShortcutCard(shortcut: shortcut);
            },
          ),
        ),
        const SizedBox(height: 24),
        SectionHeader(
          title: 'Today quick history',
          actionLabel: 'View all',
          onActionTap: () {},
        ),
        ..._recentCuts.map(
          (cut) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppListRow(
              icon: Icons.content_cut_rounded,
              title: cut.name,
              subtitle: cut.time,
              accent: cut.color,
              trailing: Text(
                cut.amount,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TodaySummary extends StatelessWidget {
  const _TodaySummary();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(42),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.bolt_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Ready for the next cut',
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          '18 cuts logged today',
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tap a service shortcut to create a fast entry once your logic is connected.',
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white.withAlpha(215),
          ),
        ),
      ],
    );
  }
}

class _ServiceShortcutCard extends StatelessWidget {
  const _ServiceShortcutCard({required this.shortcut});

  final _ServiceShortcut shortcut;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return SizedBox(
      width: 148,
      child: AppCard(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolidIconBox(icon: shortcut.icon, color: primary),
            const Spacer(),
            Text(
              shortcut.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              shortcut.price,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withAlpha(150),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardMetric {
  const _DashboardMetric({
    required this.label,
    required this.value,
    required this.footer,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String footer;
  final IconData icon;
  final Color color;
}

class _ServiceShortcut {
  const _ServiceShortcut(this.name, this.price, this.icon);

  final String name;
  final String price;
  final IconData icon;
}

class _RecentCut {
  const _RecentCut(this.name, this.time, this.amount, this.color);

  final String name;
  final String time;
  final String amount;
  final Color color;
}
