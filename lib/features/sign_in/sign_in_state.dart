// Classe abstrata para representar o estado da tela de login (sing_in).
abstract class SignInState {}

// Estado inicial da tela de login.
class SignInStateInitial extends SignInState {}

// Estado de carregamento da tela de login.
class SignInStateLoading extends SignInState {}

// Estado de sucesso da tela de login.
class SignInStateSuccess extends SignInState {}

// Estado de erro da tela de login, com uma mensagem de erro específica.
class SignInStateError extends SignInState {
  final String message;

  SignInStateError(this.message);
}