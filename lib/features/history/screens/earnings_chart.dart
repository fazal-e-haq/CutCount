import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A bar-chart widget that visualises weekly earnings.
///
/// Improvements over the previous version:
/// • Responsive – uses [LayoutBuilder] so the chart fills whatever width is
///   available, and bar widths are computed dynamically.
/// • Animated – bars smoothly transition when the data changes.
/// • Theme-aware – tooltip colours come from the current [ColorScheme].
/// • Left-axis labels – abbreviated amounts (1K, 2K …) give the reader a
///   sense of scale.
/// • Today highlight – the last bar uses [ColorScheme.tertiary] to draw
///   attention to the current day.
/// • Friendly empty state – a message is shown when every value is zero.
class EarningsChart extends StatelessWidget {
  const EarningsChart({
    super.key,
    required this.weeklyEarnings,
    required this.currencySymbol,
  });

  /// Each entry maps a label (e.g. "Mon") to the earnings amount for that day.
  final List<MapEntry<String, double>> weeklyEarnings;
  final String currencySymbol;

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Returns `true` when there is nothing meaningful to display.
  bool get _allZero =>
      weeklyEarnings.isEmpty ||
      weeklyEarnings.every((e) => e.value == 0);

  /// Abbreviates large numbers: 1200 → "1.2K", 0 → "0".
  static String _abbreviateAmount(double value) {
    if (value >= 1000) {
      final k = value / 1000;
      // Drop the decimal when it's a round thousand (e.g. 2000 → "2K").
      return k == k.roundToDouble()
          ? '${k.toInt()}K'
          : '${k.toStringAsFixed(1)}K';
    }
    return value.toInt().toString();
  }

  /// Picks a nice round interval for the left-axis labels so that we get
  /// roughly 4-6 gridlines regardless of the data range.
  static double _computeInterval(double maxY) {
    if (maxY <= 0) return 1;
    // Target ~5 intervals.
    final raw = maxY / 5;
    // Round to a "nice" number (power-of-ten multiples of 1, 2, or 5).
    final magnitude = _pow10((math.log(raw) / math.ln10).floor().toDouble());
    final residual = raw / magnitude;
    if (residual <= 1) return magnitude;
    if (residual <= 2) return 2 * magnitude;
    if (residual <= 5) return 5 * magnitude;
    return 10 * magnitude;
  }

  static double _pow10(double exp) {
    double result = 1;
    final n = exp.abs().toInt();
    for (var i = 0; i < n; i++) {
      result *= 10;
    }
    return exp < 0 ? 1 / result : result;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // ------ Empty / all-zero state ------
    if (_allZero) {
      return Card(
        elevation: 0,
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bar_chart_rounded,
                  size: 48, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
              const SizedBox(height: 12),
              Text(
                'No earnings this week',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Start logging cuts to see your earnings chart here.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // ------ Compute axis bounds ------
    final maxEarnings =
        weeklyEarnings.fold<double>(0, (max, e) => e.value > max ? e.value : max);
    final maxY = maxEarnings == 0 ? 1000.0 : maxEarnings * 1.2;
    final interval = _computeInterval(maxY);

    // Index of the last bar – used to highlight "today".
    final todayIndex = weeklyEarnings.length - 1;

    // ------ Responsive layout via LayoutBuilder ------
    return LayoutBuilder(
      builder: (context, constraints) {
        // Dynamically size bars so they never overflow on narrow screens and
        // don't look too thin on tablets.
        // Reserve ~40 % of available width for spacing & padding, distribute
        // the rest evenly among the bars, then clamp to a sensible range.
        final barCount = weeklyEarnings.length;
        final availableForBars = constraints.maxWidth * 0.6;
        final computedWidth = (availableForBars / barCount).clamp(8.0, 28.0);

        // Chart height scales with width but is clamped to stay readable.
        final chartHeight = (constraints.maxWidth / 1.7).clamp(180.0, 360.0);

        return Card(
          elevation: 0,
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ------ Title ------
                Text(
                  'Weekly Earnings',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 24),

                // ------ Chart ------
                SizedBox(
                  height: chartHeight,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,

                      // ── Animation ──────────────────────────────────────────
                      // Smoothly animate bar heights when the data changes.
                      // (fl_chart applies these when the BarChartData object is
                      // replaced with one that has different values.)

                      // ── Tooltip ────────────────────────────────────────────
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          // Theme-aware tooltip background.
                          tooltipBorder: BorderSide.none,
                          getTooltipColor: (_) => colorScheme.inverseSurface,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '$currencySymbol ${rod.toY.toInt()}',
                              TextStyle(
                                // Theme-aware text colour.
                                color: colorScheme.onInverseSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),

                      // ── Titles / Axis labels ──────────────────────────────
                      titlesData: FlTitlesData(
                        show: true,

                        // Bottom axis – day labels.
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= weeklyEarnings.length) {
                                return const SizedBox.shrink();
                              }
                              // Truncate long labels on narrow screens.
                              final label = weeklyEarnings[index].key;
                              final displayLabel = constraints.maxWidth < 360
                                  ? (label.length > 2 ? label.substring(0, 2) : label)
                                  : label;
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  displayLabel,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: constraints.maxWidth < 300 ? 10 : null,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ),

                        // Left axis – abbreviated amount labels (0, 1K, 2K …).
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: interval,
                            getTitlesWidget: (value, meta) {
                              // Skip the very top label when it would overlap
                              // with the chart boundary.
                              if (value == meta.max) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                _abbreviateAmount(value),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              );
                            },
                          ),
                        ),

                        // Hide top & right axes.
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),

                      // ── Grid & border ─────────────────────────────────────
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),

                      // ── Bar groups ────────────────────────────────────────
                      barGroups: weeklyEarnings.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        // Highlight the last bar ("today") with the tertiary
                        // colour; all other bars use the primary colour.
                        final isToday = index == todayIndex;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data.value,
                              color: isToday
                                  ? colorScheme.tertiary
                                  : colorScheme.primary,
                              width: computedWidth,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                              // Subtle background track behind each bar.
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: maxY,
                                color: colorScheme.primary.withValues(alpha: 0.07),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),

                    // ── Animation ─────────────────────────────────────────
                    // Animate bar height changes over 300 ms with an ease-out
                    // curve for a polished feel.
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
