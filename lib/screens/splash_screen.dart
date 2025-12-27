import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset("assets/images/splash.png", height: 400),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                context.pushNamed('/SignIn');
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffE95401),
                  borderRadius: .circular(10),
                ),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                context.pushNamed('/SignUp');
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE95401)),
                  borderRadius: .circular(10),
                ),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
