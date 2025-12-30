import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 26),
          child: Column(
            children: [
              Image.asset("assets/images/splash.png"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Text(
                'Organize Barbershop\nWorkflow With Ease.',
                textAlign: .center,
                style: GoogleFonts.poppins(
                  color: Color(0xffE95401),
                  fontWeight: .w500,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Easily track every haircut, monitor daily earnings, and keep accurate records to manage your barbershop’s performance efficiently.',
                textAlign: .center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.17),
              Row(
                mainAxisAlignment: .center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushReplacement('/SignIn');
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Color(0xffE95401),
                        borderRadius: .circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      context.pushReplacement('/SignUp');
                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.bodyLarge,
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
