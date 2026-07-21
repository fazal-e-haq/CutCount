import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/routes/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<_TrendPoint> _cutsTrend = const [
    _TrendPoint(label: 'Jan', value: 18),
    _TrendPoint(label: 'Feb', value: 22),
    _TrendPoint(label: 'Mar', value: 26),
    _TrendPoint(label: 'Apr', value: 20),
    _TrendPoint(label: 'May', value: 28),
    _TrendPoint(label: 'Jun', value: 24),
    _TrendPoint(label: 'Jul', value: 31),
  ];

  final List<_TrendPoint> _amountTrend = const [
    _TrendPoint(label: 'Jan', value: 1200),
    _TrendPoint(label: 'Feb', value: 1450),
    _TrendPoint(label: 'Mar', value: 1780),
    _TrendPoint(label: 'Apr', value: 1320),
    _TrendPoint(label: 'May', value: 1900),
    _TrendPoint(label: 'Jun', value: 1680),
    _TrendPoint(label: 'Jul', value: 2140),
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.12),
                  child: Icon(
                    Icons.person,
                    size: 52,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                ReusableAutoSizeText(
                  'Muhammad Ali',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Barber shop owner',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.xl),
          Row(
            children: [
              Expanded(
                child: _ProfileStatCard(
                  title: 'All Time Cuts',
                  value: '1,284',
                  icon: Icons.content_cut,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: _ProfileStatCard(
                  title: 'All Time Amount',
                  value: 'Rs. 864,000',
                  icon: Icons.payments_rounded,
                ),
              ),
            ],
          ),
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
                    points: _cutsTrend,
                    color: Theme.of(context).colorScheme.primary,
                    valueLabelBuilder: (value) => value.toString(),
                  );
                },
              ),
            ),
          ),
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
                    points: _amountTrend,
                    color: Theme.of(context).colorScheme.secondary,
                    valueLabelBuilder: (value) => 'Rs. $value',
                  );
                },
              ),
            ),
          ),
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
                  title: Text('Export detail history of specific month'),
                  subtitle: Text('Download or share month-level records'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                CustomListTile(
                  leading: Icon(Icons.person_search_outlined),
                  title: Text('Update profile details'),
                  subtitle: Text('Edit barber and shop information'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                CustomListTile(
                  leading: Icon(Icons.receipt_long_outlined),
                  title: Text('View earnings summary'),
                  subtitle: Text('See recent revenue and service performance'),
                  trailing: Icon(Icons.chevron_right),
                ),
                Divider(height: 1),
                CustomListTile(
                  leading: Icon(Icons.qr_code_2_outlined),
                  title: Text('Share shop profile'),
                  subtitle: Text('Send your shop details to customers'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendPoint {
  const _TrendPoint({required this.label, required this.value});

  final String label;
  final int value;
}

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
