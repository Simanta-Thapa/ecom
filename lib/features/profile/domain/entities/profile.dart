// domain/entities/profile.dart
import 'package:equatable/equatable.dart';

/// Profile Entity - represents the core user profile in the domain layer
class Profile extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String? profilePic;

  /// Constructor
  const Profile({
    required this.uid,
    required this.email,
    required this.name,
    this.profilePic,
  });

  /// Equatable props for value comparison
  @override
  List<Object?> get props => [uid, name, profilePic];
}
