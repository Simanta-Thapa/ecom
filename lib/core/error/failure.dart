import 'package:equatable/equatable.dart';

abstract class Failure{
 final String msg;
 const Failure(this.msg);
}

class ServerFailure extends Failure{
 const ServerFailure([super.msg = 'Server Error']);
}

class NetworkFailure extends Failure{
 const NetworkFailure([super.msg = 'Network Failure']);
}

class AuthFailure extends Failure {
 const AuthFailure([String message = 'Authentication error']) : super(message);
}

class DatabaseFailure extends Failure{
 const DatabaseFailure([super.msg = "Database Failure"]);
}

class UnknowFailure extends Failure{
 const UnknowFailure([super.msg = "Unknow Failure"]);
}


class NoUserFailure extends Failure {
  NoUserFailure(super.msg);

 @override
 String toString() => "No user is currently logged in";
}


