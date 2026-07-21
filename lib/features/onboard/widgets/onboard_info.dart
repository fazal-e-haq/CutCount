import 'package:flutter/material.dart';

import '../../../core/widgets/auto_size_text/reusable_auto_size_text.dart';

// Full-screen onboarding content used by the PageView.
// Each page stays focused on one idea so the first-run flow feels clear and easy to scan.
class IntroInformation extends StatelessWidget {
  const IntroInformation({
    super.key,
    required this.mainTitle,
    required this.subTitle,
    required this.icon,
    required this.accentColor,
  });

  final IconData icon;
  final String mainTitle;
  final String subTitle;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isCompact = size.width < 380;
    final iconSize = isCompact ? 180.0 : (size.width < 600 ? 230.0 : 280.0);

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.78,
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  accentColor.withValues(alpha: 0.18),
                  accentColor.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: accentColor.withValues(alpha: 0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: accentColor,
                shadows: [
                  Shadow(
                    color: accentColor.withValues(alpha: 0.35),
                    blurRadius: 24,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          ReusableAutoSizeText(
            textAlign: TextAlign.left,
            maxLines: 2,
            minFontSize: 20,
            mainTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: isCompact ? 24 : 30,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 15),
          ReusableAutoSizeText(
            textAlign: TextAlign.left,
            maxLines: 5,
            minFontSize: 12,
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.7,
              fontSize: isCompact ? 14 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
