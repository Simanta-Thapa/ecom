import 'package:equatable/equatable.dart';

class UserUid extends Equatable{
  final String uid;

  const UserUid(this.uid);

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
