import 'package:flutter/material.dart';

// A class for show information on onboarding pages which include Text and image
class IntroInformation extends StatelessWidget {
  // Constructor
  const IntroInformation({
    super.key,
    // required this.imagePath,
    required this.mainTitle,
    required this.subTitle,
  });
  // Global variables
  // final String imagePath;
  final String mainTitle;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Icon(
            Icons.phone_iphone,
            size: 300,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        // Onboard Image
        // Image.asset(
        //   imagePath,
        //   width: size.width * 0.9,
        //   height: size.height * 0.35,
        //   fit: BoxFit.contain,
        // ),
        const Spacer(),

        // Main Title
        Text(
          mainTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        // Subtitle / Body
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
