// Classe abstract para representar o estado da tela sing_in.
abstract class SignInState {}

class SignInStateInitial extends SignInState {}

class SignInStateLoading extends SignInState {}

class SignInStateSuccess extends SignInState {}

class SignInStateError extends SignInState {
  final String message;

  SignInStateError(this.message);
}