import 'package:ecommerce/core/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Authoption extends StatefulWidget {
  const Authoption({super.key});

  @override
  State<Authoption> createState() => _AuthoptionState();
}

class _AuthoptionState extends State<Authoption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [

              CustomButton(
                onPressed: (){

                  context.push('/register');
                }, 
                buttonText:"Create Account"
                ),

              CustomButton(
                onPressed: (){
                  context.push('/login');
                }, 
                buttonText:"Already Have an account"
                ),

            ],
          ),
        )
        ),
    );
  }
}