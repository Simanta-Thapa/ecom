import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart'; // your Profile entity

class ProfileModel extends Profile with EquatableMixin {

  const ProfileModel({
    required String id,
    required super.name,
    required super.email,
    super.profilePic,
  }) : super(uid: id);

  // From JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePic: json['profilePic'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id':uid,
      'name': name,
      'email':email,
      'profilePic': profilePic,
    };
  }

  @override
  List<Object?> get props => [uid, name, profilePic,email];
}
