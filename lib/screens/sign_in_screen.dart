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
          child: Padding(
            padding: .symmetric(horizontal: 26),
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome backiewhfefhehfdwefhqoidfeofheifh',
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: 50),
                LoginTextfield(
                  isObsure: false,
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                ),
                SizedBox(height: 20),
                LoginTextfield(
                  isObsure: false,
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 100),
                CustomButton(
                  onTap: () {
                    context.pushReplacement('/Home');
                  },
                  text: 'Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
