import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/custom_button_2.dart';
import 'package:ecommerce/core/widgets/custom_nav_bar.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final pwd = pwdController.text;
    context.read<AuthBloc>().add(Login(email, pwd));
  }

  void googleSignIn() {
    context.read<AuthBloc>().add(GoogleSign());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {

          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => CustomNavBar(),
          //     ),
          //     (route) => false,
          //   );

        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Login Account",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please login with your registered account",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Enter your email",
                  obscureText: false,
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: pwdController,
                  hintText: "Enter password",
                  obscureText: true,
                  icon: const Icon(Icons.password),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  ),
                ),

                const SizedBox(height: 20),

                CustomButton(
                  onPressed: state is AuthLoading ? null : login,
                  buttonText: "Sign In",
                  isLoading: state is AuthLoading,
                ),

                const SizedBox(height: 20),
                const Center(child: Text("Or sign in with")),
                const SizedBox(height: 15),

                CustomButton2(
                  buttonText_2: "Sign in with Google",
                  onPressed: googleSignIn,
                ),
                const SizedBox(height: 10),

                CustomButton2(
                  buttonText_2: "Sign in with Facebook",
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
