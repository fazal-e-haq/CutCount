import 'package:cut_count/widgets/custom_button.dart';
import 'package:cut_count/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  void signing_up() {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: emailController.toString(),
      password: passwordController.toString(),
    );
  }

  void verifying(BuildContext context) {
    if (userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (!emailController.text.endsWith('@gmail.com')) {
        print('please provide right email');
      } else {
        signing_up();
        context.pushReplacement('/SignIn');
      }
    }
  }

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Sign Up with your email and password  \nor continue with social media',
                  textAlign: .center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                LoginTextfield(
                  isObsure: false,
                  controller: userNameController,
                  hintText: 'User name',
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 10),
                LoginTextfield(
                  isObsure: false,
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail),
                ),
                SizedBox(height: 10),
                LoginTextfield(
                  isObsure: true,
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 10),
                LoginTextfield(
                  isObsure: true,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                CustomButton(
                  onTap: () {
                    verifying(context);
                  },
                  text: 'Sign Up',
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () => context.pushNamed('/SignIn'),
                      child: Text('Sign In', style: TextStyle(fontSize: 14)),
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
