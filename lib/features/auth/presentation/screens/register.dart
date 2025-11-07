import 'package:ecommerce/core/const/const.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/custom_nav_bar.dart';
import 'package:ecommerce/core/widgets/custom_text_form_field.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();
  TextEditingController retryPwdController = TextEditingController();

  void registerUser() {
    final userName = userNameController.text;
    final email = emailController.text;
    final pwd = pwdController.text;

    context.read<AuthBloc>().add(Register(email, pwd, userName));
  }

  void setPasswordVisible() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          
          // if (state is AuthAuthenticated) {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => CustomNavBar(user: state.user),
          //     ),
          //     (route) => false,
          //   );
          // }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Account"),
                    height,
                    Text("Start shopping with create your account"),
                    height,

                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Enter Your UserName",
                      ),
                    ),

                    height,

                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Enter Your Email",
                      icon: Icon(Icons.email),
                    ),

                    height,

                    height,

                    CustomTextFormField(
                      obscureText: true,
                      controller: pwdController,
                      hintText: "Enter password",
                      icon: Icon(Icons.password),
                    ),

                    height,

                    TextFormField(
                      obscureText: true,
                      controller: retryPwdController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Enter Your UserName",
                      ),
                    ),

                    height,

                   CustomButton(
                    onPressed:state is AuthLoading ? null : registerUser, 
                    buttonText:"Sign In",
                    isLoading: state is AuthLoading,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
