import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/onboarding_provider.dart';
import '../widgets/onboard_info.dart';

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

  @override
  Widget build(BuildContext context) {
    // Primary orange color from the active theme
    final Color primary = Theme.of(context).colorScheme.primary;
    // Outline color used for inactive dot borders — adapts to light/dark
    final Color outline = Theme.of(context).colorScheme.outline;
    final provider = context.read<OnboardingProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (value) {
                    provider.onChange(value);
                  },
                  itemCount: provider.introInfo.length,
                  itemBuilder: (context, index) {
                    final item = provider.introInfo[index];
                    return IntroInformation(
                      // imagePath: item.imagePath,
                      mainTitle: item.mainTitle,
                      subTitle: item.subTitle,
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Selector<OnboardingProvider, int>(
                selector: (contextOfProvider, provider) =>
                    provider.currentIndex,
                builder: (contextOfProvider, currentIndex, child) {
                  return Row(
                    mainAxisAlignment: .center,
                    children: List.generate(
                      contextOfProvider
                          .read<OnboardingProvider>()
                          .introInfo
                          .length,
                      (index) {
                        final isActive = index == currentIndex;
                        return AnimatedContainer(
                          height: 15,
                          width: isActive ? 40 : 20,
                          margin: const EdgeInsetsGeometry.symmetric(
                            horizontal: 3,
                          ),
                          duration: const Duration(milliseconds: 700),
                          decoration: BoxDecoration(
                            // Active dot: filled with primary orange
                            // Inactive dot: transparent fill with outline border
                            color: isActive ? primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: isActive ? Colors.transparent : outline,
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Selector<OnboardingProvider, int>(
                  selector: (p0, p1) => p1.currentIndex,
                  builder: (providerContext, value, child) {
                    final provider = providerContext.read<OnboardingProvider>();
                    return ElevatedButton(
                      onPressed: () {
                        if (provider.currentIndex ==
                            provider.introInfo.length - 1) {
                          provider.setOnboardingSeen();
                          // go() replaces the navigation stack — user can't press back to onboarding
                          context.go('/BottomBar');
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      child: const Text('Next'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
