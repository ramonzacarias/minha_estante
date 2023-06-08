// Classe abstrata para representar os estados da tela de Splash.
abstract class SplashState {}

// Estado inicial da tela de Splash.
class SplashStateInitial extends SplashState {}

// Estado de carregamento da tela de Splash.
class SplashStateLoading extends SplashState {}

// Estado de sucesso da tela de Splash.
class SplashStateSuccess extends SplashState {}

// Estado de erro da tela de Splash.
class SplashStateError extends SplashState {}