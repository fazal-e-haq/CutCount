import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/buttons/reusable_button.dart';
import '../../../routes/routing_name.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboard_info.dart';

// First-run experience for the app.
// This screen explains the value of the product before the user enters the main flow.
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _goNext(OnboardingProvider provider) {
    if (provider.currentIndex == provider.introInfo.length - 1) {
      provider.setOnboardingSeen();
      context.goNamed(RouteNames.home);
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final provider = context.read<OnboardingProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface.withValues(alpha: 0.85),
              theme.scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width < 380 ? 16 : 20,
              vertical: 12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Barber only',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.goNamed(RouteNames.home),
                      child: const Text('Skip'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: provider.onChange,
                    itemCount: provider.introInfo.length,
                    itemBuilder: (context, index) {
                      final item = provider.introInfo[index];
                      final palette = [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                        theme.colorScheme.primary.withValues(alpha: 0.88),
                      ];

                      return IntroInformation(
                        icon: item.icon,
                        mainTitle: item.mainTitle,
                        subTitle: item.subTitle,
                        accentColor: palette[index % palette.length],
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                Selector<OnboardingProvider, int>(
                  selector: (_, provider) => provider.currentIndex,
                  builder: (context, currentIndex, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(provider.introInfo.length, (
                        index,
                      ) {
                        final isActive = index == currentIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                          height: 10,
                          width: isActive ? 30 : 10,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outline.withValues(
                                    alpha: 0.35,
                                  ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.lg),
                Selector<OnboardingProvider, int>(
                  selector: (_, provider) => provider.currentIndex,
                  builder: (context, currentIndex, child) {
                    final isLastPage =
                        currentIndex == provider.introInfo.length - 1;

                    return Column(
                      children: [
                        ReusableButton(
                          text: isLastPage ? 'Get Started' : 'Next',
                          onPressed: () => _goNext(provider),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isLastPage
                              ? 'You are ready to manage the shop.'
                              : 'Swipe to continue through the app features.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
