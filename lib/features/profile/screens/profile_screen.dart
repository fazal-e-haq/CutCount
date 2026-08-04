import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/routes/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Provider imports – SettingsProvider owns the profile name/subtitle;
// HistoryProvider owns all-time stats and monthly trend data.
import '../../settings/providers/settings_provider.dart';
import '../../history/providers/history_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('Profile'),
      appBarActions: [
        IconButton(
          onPressed: () => context.pushNamed(RouteNames.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      // Consumer2 listens to both providers so the UI rebuilds when
      // the user edits their name OR when history data changes.
      body: Consumer2<SettingsProvider, HistoryProvider>(
        builder: (context, settings, history, child) {
          // Build trend point lists from real monthly history data.
          // If there is no data yet we show a single zero-value point
          // so the chart widgets don't receive an empty list.
          final cutsTrend = history.monthlyTrendCuts.isNotEmpty
              ? history.monthlyTrendCuts
                  .map((e) => _TrendPoint(label: e.key, value: e.value))
                  .toList()
              : [const _TrendPoint(label: '-', value: 0)];

          final amountTrend = history.monthlyTrendAmount.isNotEmpty
              ? history.monthlyTrendAmount
                  .map((e) => _TrendPoint(label: e.key, value: e.value))
                  .toList()
              : [const _TrendPoint(label: '-', value: 0)];

          // Format the all-time numbers with thousands separators.
          final cutsFormatted =
              history.allTimeCutsCount.toString().replaceAllMapped(
                    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                    (m) => '${m[1]},',
                  );
          final amountFormatted =
              history.allTimeAmountValue.toString().replaceAllMapped(
                    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                    (m) => '${m[1]},',
                  );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Profile header ----------
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: AppSizes.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableAutoSizeText(
                              settings.userName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              settings.userSubtitle,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit profile',
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                        onPressed: () => _showEditProfileSheet(
                          context,
                          settings,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- All-time stat cards ----------
              const SizedBox(height: AppSizes.xl),
              Row(
                children: [
                  Expanded(
                    child: _ProfileStatCard(
                      title: 'All Time Cuts',
                      value: cutsFormatted,
                      icon: Icons.content_cut,
                    ),
                  ),
                  const SizedBox(width: AppSizes.md),
                  Expanded(
                    child: _ProfileStatCard(
                      title: 'All Time Amount',
                      value: '${settings.currencySymbol} $amountFormatted',
                      icon: Icons.payments_rounded,
                    ),
                  ),
                ],
              ),

              // ---------- Cuts trend chart ----------
              const SizedBox(height: AppSizes.xl),
              ReusableAutoSizeText(
                'All time cuts',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return _LineChartCard(
                        height: constraints.maxWidth < 360 ? 150 : 180,
                        title: 'All time cuts trend',
                        points: cutsTrend,
                        color: Theme.of(context).colorScheme.primary,
                        valueLabelBuilder: (value) => value.toString(),
                      );
                    },
                  ),
                ),
              ),

              // ---------- Amount trend chart ----------
              const SizedBox(height: AppSizes.xl),
              ReusableAutoSizeText(
                'All time amount',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return _LineChartCard(
                        height: constraints.maxWidth < 360 ? 150 : 180,
                        title: 'All time amount trend',
                        points: amountTrend,
                        color: Theme.of(context).colorScheme.secondary,
                        valueLabelBuilder: (value) => '${settings.currencySymbol} $value',
                      );
                    },
                  ),
                ),
              ),

              // ---------- Quick actions ----------
              const SizedBox(height: AppSizes.xl),
              ReusableAutoSizeText(
                'Quick actions',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: const [
                    CustomListTile(
                      leading: Icon(Icons.history_toggle_off),
                      title:
                          Text('Export detail history of specific month'),
                      subtitle:
                          Text('Download or share month-level records'),
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

  // -----------------------------------------------------------------------
  // Bottom sheet that lets the user edit their profile name and subtitle.
  // Pre-fills the text fields with current values from SettingsProvider.
  // -----------------------------------------------------------------------
  void _showEditProfileSheet(
    BuildContext context,
    SettingsProvider settings,
  ) {
    final nameController = TextEditingController(text: settings.userName);
    final subtitleController =
        TextEditingController(text: settings.userSubtitle);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          // Shift content up when the keyboard appears.
          padding: EdgeInsets.only(
            left: AppSizes.lg,
            right: AppSizes.lg,
            top: AppSizes.xl,
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom + AppSizes.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Profile',
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.lg),
              // Name input field
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              // Subtitle / tagline input field
              TextField(
                controller: subtitleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Subtitle',
                  hintText: 'e.g. Barber shop owner',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              // Save button persists changes via SettingsProvider.
              FilledButton(
                onPressed: () {
                  final newName = nameController.text.trim();
                  final newSubtitle = subtitleController.text.trim();

                  // Only update if the user actually typed something.
                  if (newName.isNotEmpty) {
                    settings.updateName(newName);
                  }
                  if (newSubtitle.isNotEmpty) {
                    settings.updateSubtitle(newSubtitle);
                  }

                  Navigator.pop(sheetContext);

                  // Show a brief confirmation so the user knows it saved.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// -------------------------------------------------------------------------
// Private helper classes used only inside this file.
// -------------------------------------------------------------------------

/// A single data point on the trend line chart.
class _TrendPoint {
  const _TrendPoint({required this.label, required this.value});

  final String label;
  final int value;
}

/// Compact stat card showing an icon, title, and formatted value.
class _ProfileStatCard extends StatelessWidget {
  const _ProfileStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}

/// Reusable line chart card that draws a trend line with labeled data points.
class _LineChartCard extends StatelessWidget {
  const _LineChartCard({
    required this.height,
    required this.title,
    required this.points,
    required this.color,
    required this.valueLabelBuilder,
  });

  final double height;
  final String title;
  final List<_TrendPoint> points;
  final Color color;
  final String Function(int value) valueLabelBuilder;

  @override
  Widget build(BuildContext context) {
    final maxValue = points.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minValue = points.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final range = (maxValue - minValue).clamp(1, 1 << 31);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ChartLegend(color: color, label: title),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          height: height,
          child: CustomPaint(
            painter: _LineChartPainter(
              points: points,
              color: color,
              minValue: minValue,
              range: range,
            ),
            child: Stack(
              children: [
                ...points.asMap().entries.map((entry) {
                  final point = entry.value;
                  return Align(
                    alignment: Alignment(
                      points.length == 1
                          ? 0
                          : -1 + (2 * entry.key / (points.length - 1)),
                      1,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            valueLabelBuilder(point.value),
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: height - 68),
                          Text(point.label),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.points,
    required this.color,
    required this.minValue,
    required this.range,
  });

  final List<_TrendPoint> points;
  final Color color;
  final int minValue;
  final int range;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final linePath = Path();
    final fillPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = size.width * (i / (points.length - 1));
      final normalized = (points[i].value - minValue) / range;
      final y = size.height - (normalized * (size.height - 28)) - 18;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      canvas.drawCircle(Offset(x, y), 4, Paint()..color = color);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.minValue != minValue ||
        oldDelegate.range != range;
  }
}
