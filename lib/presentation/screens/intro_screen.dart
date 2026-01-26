import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Splash Image
              Image.asset(
                "assets/images/pic.png",
                width: size.width * 0.9,
                fit: BoxFit.contain,
              ),
              SizedBox(height: size.height * 0.08),

              // Main Title
              Text(
                'Organize Barbershop\nWorkflow With Ease.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: size.height * 0.02),

              // Subtitle / Body
              Text(
                'Easily track every haircut, monitor daily earnings, and keep accurate records to manage your barbershop efficiently.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.17),

              // Sign In / Sign Up Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign In Button
                  GestureDetector(
                    onTap: () {
                      context.pushReplacement('/SignIn');
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        color: .new(0XFFE95401),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),

                  // Sign Up Button
                  GestureDetector(
                    onTap: () {
                      context.pushReplacement('/SignUp');
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(color: .new(0xffE95401), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
