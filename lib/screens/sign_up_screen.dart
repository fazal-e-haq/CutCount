import 'package:cut_count/widgets/custom_button.dart';
import 'package:cut_count/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
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
                'Create Account',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Subtitle
              Text(
                'Create an account so you can manage your work efficiently',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.08),

              // Username
              LoginTextfield(
                isObsure: false,
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
                controller: _userNameController,
              ),
              SizedBox(height: size.height * 0.02),

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
              SizedBox(height: size.height * 0.06),

              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onTap: () {
                  context.go('/Home');
                },
              ),
              SizedBox(height: size.height * 0.02),

              // Already have account
              GestureDetector(
                onTap: () {
                  context.go('/SignIn');
                },
                child: Text(
                  'Already have an account?',
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
