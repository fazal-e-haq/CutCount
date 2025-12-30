import 'package:cut_count/widgets/custom_button.dart';
import 'package:cut_count/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                Text(
                  'SignIn here',
                  style: GoogleFonts.poppins(
                    color: Color(0xffE95401),
                    fontSize: 26,
                    fontWeight: .w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                Text(
                  'Welcome back you\'ve\nbeen missed!',
                  textAlign: .center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                LoginTextfield(
                  isObsure: false,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                  controller: _emailController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                LoginTextfield(
                  isObsure: true,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  controller: _passwordController,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},

                  child: Align(
                    alignment: .centerRight,
                    child: Text(
                      'Forget password?',
                      style: GoogleFonts.poppins(
                        color: Color(0xffE95401),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.17),

                CustomButton(
                  text: 'Sign In',
                  onTap: () {
                    context.go('/Home');
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    context.go('/SignUp');
                  },
                  child: Text('Create new account'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                Text('or continue with'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.golf_course_outlined, size: 50),
                    Icon(Icons.golf_course_outlined, size: 50),
                    Icon(Icons.golf_course_outlined, size: 50),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
