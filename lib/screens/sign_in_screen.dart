import 'package:cut_count/widgets/custom_button.dart';
import 'package:cut_count/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),

              // Title
              Text(
                'Sign In Here',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Subtitle
              Text(
                'Welcome back, you\'ve been missed!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.08),

              // Email
              LoginTextfield(
                isObsure: false,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.mail),
                controller: _emailController,
              ),
              SizedBox(height: size.height * 0.02),

              // Password
              LoginTextfield(
                isObsure: true,
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                controller: _passwordController,
              ),
              const SizedBox(height: 8),

              // Forget password
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.06),

              // Sign In Button
              CustomButton(
                text: 'Sign In',
                onTap: () {
                  context.go('/BottomBar');
                },
              ),
              SizedBox(height: size.height * 0.02),

              // Create account
              GestureDetector(
                onTap: () {
                  context.go('/SignUp');
                },
                child: Text(
                  'Create new account',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(height: size.height * 0.06),

              // Social login
              Text('or continue with'),
              SizedBox(height: size.height * 0.02),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: const [
                  Icon(Icons.golf_course_outlined, size: 40),
                  Icon(Icons.golf_course_outlined, size: 40),
                  Icon(Icons.golf_course_outlined, size: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
