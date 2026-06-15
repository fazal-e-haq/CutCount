import 'package:cut_count/Providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Intro pages details
    final onboardProvider = context.watch<OnboardingProvider>();
    final int currentIndex = onboardProvider.currentIndex;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Stack(
            children: [
              PageView.builder(
                controller: onboardProvider.pageController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (value) {
                  context.read<OnboardingProvider>().onChange(value);
                },
                itemCount: onboardProvider.introInfo.length,
                itemBuilder: (context, index) {
                  final item = onboardProvider.introInfo[index];
                  return IntroInformation(
                    imagePath: item.imagePath,
                    mainTitle: item.mainTitle,
                    subTitle: item.subTitle,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated indicators of pages
            Selector<OnboardingProvider, int>(
              selector: (contextOfProvider, provider) => provider.currentIndex,
              builder: (contextOfProvider, currentIndex, child) {
                return Row(
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
                          color: isActive ? Color(0xffE95401) : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isActive
                                ? Colors.transparent
                                : Color(0xffE95401),
                            width: 2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Button for go to next page
            FloatingActionButton(
              onPressed: () async {
                if (currentIndex == onboardProvider.introInfo.length - 1) {
                  onboardProvider.setOnboardingSeen();
                  context.push('/BottomBar');
                } else {
                  onboardProvider.pageController.nextPage(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                  );
                }
              },
              child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// A class for show information on onboarding pages which include Text and image
class IntroInformation extends StatelessWidget {
  // Constructor
  const IntroInformation({
    super.key,
    required this.imagePath,
    required this.mainTitle,
    required this.subTitle,
  });
  // Global variables
  final String imagePath;
  final String mainTitle;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Onboard Image
        Image.asset(
          imagePath,
          width: size.width * 0.9,
          height: size.height * 0.35,
          fit: BoxFit.contain,
        ),
        SizedBox(height: size.height * 0.13),

        // Main Title
        Text(
          mainTitle,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xffE95401),
          ),
        ),
        SizedBox(height: size.height * 0.025),
        // Subtitle / Body
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 16,
            fontWeight: .w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
