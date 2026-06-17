import 'package:flutter/material.dart';

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
        SizedBox(height: size.height * 0.03),

        // Onboard Image
        Image.asset(
          imagePath,
          width: size.width * 0.9,
          height: size.height * 0.35,
          fit: BoxFit.contain,
        ),
        SizedBox(height: size.height * 0.15),

        // Main Title
        Text(
          mainTitle,
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Color(0xffE95401)),
        ),
        SizedBox(height: size.height * 0.02),
        // Subtitle / Body
        Text(
          subTitle,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
