import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body:SafeArea(
        child:Column(
          children: [
             ListTile(
              leading: Icon(Icons.logout),
              title:Text("Log Out...."),
              onTap: (){
                context.read<AuthBloc>().add(LogOut());
              },
             ),
            ListTile(
              onTap: (){
                context.push('/updateProfile');
              },
              leading:Icon(Icons.person),
              title: Text("Update Your Profile"),
            ),
          ]
        ),
        ),
    );
  }
}