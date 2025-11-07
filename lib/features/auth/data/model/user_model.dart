import 'package:ecommerce/features/auth/domain/entites/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends UserUid with EquatableMixin {
  final String? email;
  final String? name;
  const UserModel(super.id, {this.email, this.name});

  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      user.uid as String,
      email: user.email as String?,
      name: user.displayName as String?,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      (map['id'] as String),
      email: map['email'] as String,
      name: map['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'email':email,
      'name':name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid,email,name];
}
