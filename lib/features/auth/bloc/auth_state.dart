// Base class
import 'package:ecommerce/features/auth/domain/entites/user.dart';
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable{
  @override
  List<Object?> get props => [];
}


final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}


final class AuthAuthenticated extends AuthState {
 final UserUid user;

 AuthAuthenticated(this.user);


 @override
 List<Object?> get props => [user];

}

// When user is not logged in
final class AuthUnauthenticated extends AuthState {}

// When something went wrong
class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);


  @override
  List<Object?> get props => [message];


}
