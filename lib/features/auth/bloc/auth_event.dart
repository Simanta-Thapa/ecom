sealed class AuthEvent {}

final class AppStarted extends AuthEvent {}

final class Login extends AuthEvent {
  final String email;
  final String pwd;

  Login(this.email, this.pwd);
}

final class Register extends AuthEvent {
  final String email;
  final String pwd;
  final String name;

  Register(this.email, this.pwd, this.name);
}

final class GoogleSign extends AuthEvent {}

final class LogOut extends AuthEvent {}
