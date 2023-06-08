// Classe abstrata para representar o estado da tela de cadastro (sing_up).
abstract class SignUpState {}

// Estado inicial da tela de cadastro.
class SignUpInitialState extends SignUpState {}

// Estado de carregamento da tela de cadastro.
class SignUpLoadingState extends SignUpState {}

// Estado de sucesso da tela de cadastro.
class SignUpSuccessState extends SignUpState {}

// Estado de erro da tela de cadastro, com uma mensagem de erro específica.
class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState(this.message);
}