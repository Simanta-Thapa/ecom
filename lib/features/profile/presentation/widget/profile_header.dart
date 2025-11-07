import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_state.dart';
import 'package:ecommerce/features/profile/presentation/widget/profile_header_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.10;
    return BlocSelector<ProfileBloc, ProfileState, ProfileHeaderData>(
      selector: (state) {
        final profile = state.profile;
        return ProfileHeaderData(
          name: profile?.name ?? "Guest",
          email: profile?.email ?? "",
          isLoading: state.isLoading,
          errorMessage: state.errorMessage,
        );
      },
      builder:(context,data){
        if(data.isLoading){
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );



        }

        if(data.errorMessage != null){
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Error: ${data.errorMessage}',
                style: TextStyle(color: Colors.red)),
          );



        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              child: Icon(Icons.person),
            ),




                Text(data.name),
                Text(data.email)




          ],
        );
      },
    );
  }
}
