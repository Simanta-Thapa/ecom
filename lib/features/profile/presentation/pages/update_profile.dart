import 'dart:convert';

import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_state.dart';
import 'package:ecommerce/features/profile/presentation/widget/update_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc,ProfileState>(
      builder: (BuildContext context, ProfileState state) { 
        final profileData = state.profile;
        
        if(profileData == null || state.isLoading){
          return Center(child: CircularProgressIndicator(),);
          
        }




        if (nameController.text.isEmpty) {
          nameController.text = profileData.name;
        }
        
        return Scaffold(
          body:SafeArea(
              child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: profileData.profilePic != null ? MemoryImage(base64Decode(profileData.profilePic!)) : null,
                    ),
                    UpdateTextFormField(
                      controller: nameController,
                        hintText: "Enter your name"
                    )
                  ],
                ),
              ),
          ) ,
        );
      },
      
    );
  }
}
