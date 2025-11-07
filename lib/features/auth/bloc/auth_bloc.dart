
import 'package:ecommerce/features/auth/domain/usecase/get_current_user_use_case.dart';
import 'package:ecommerce/features/auth/domain/usecase/login_use_case.dart';
import 'package:ecommerce/features/auth/domain/usecase/logout_use_case.dart';
import 'package:ecommerce/features/auth/domain/usecase/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/auth/domain/entites/user.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial()) {
    // App started → check current user
    on<AppStarted>(_onAppStarted);

    // Email/password login
    on<Login>(_onLogin);


    on<Register>(_onRegister);

    // // Google sign in
    // on<GoogleSign>(_onGoogleSign);
    //
    // Log out
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    final result = await getCurrentUserUseCase.call();
    result.fold(
          (failure)=>emit(AuthFailure(_mapFailureToMessage(failure))),
          (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );

  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

      final result = await loginUseCase.call(email:event.email,pwd: event.pwd);
      result.fold(
          (failure)=>emit(AuthFailure(_mapFailureToMessage(failure))),
          (user)=>emit(AuthAuthenticated(user)),
      );


  }


  Future<void> _onRegister(Register event,Emitter<AuthState> emit) async{
    emit(AuthLoading());
    final result = await registerUseCase.call(email:event.email,pwd: event.pwd,name: event.name);
    result.fold(
          (failure)=>emit(AuthFailure(_mapFailureToMessage(failure))),
          (user)=>emit(AuthAuthenticated(user)),
    );

  }

  Future<void> _onLogOut(LogOut event,Emitter<AuthState> emit) async{
     final result = await logoutUseCase.call();
     result.fold(
           (failure)=>emit(AuthFailure(_mapFailureToMessage(failure))),
           (_)=>emit(AuthUnauthenticated()),
     );
  }

  String _mapFailureToMessage(failure) {
    // Customize based on different Failure types
    return failure.toString();
  }

}
