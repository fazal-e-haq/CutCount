import 'package:cut_count/widgets/custom_button.dart';
import 'package:cut_count/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: .symmetric(horizontal: 26),
            child: Column(
              mainAxisAlignment: .center,

              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Sign in with your email and password  \nor continue with social media',
                  textAlign: .center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                LoginTextfield(
                  isObsure: false,
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                ),
                SizedBox(height: 20),
                LoginTextfield(
                  isObsure: true,
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.22),
                CustomButton(
                  onTap: () {
                    context.pushReplacement('/Home');
                  },
                  text: 'Sign In',
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Don\'t have an account ? ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed('/SignUp'),
                      child: Text('Sign Up', style: TextStyle(fontSize: 15)),
                    ),
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
