import '../commom/models/user_model.dart';

// Interface para a autenticação do usuario

abstract class AuthService {
  Future<UserModel> signUp({
    String? name, 
    required String email, 
    required String password,
  });

  Future signIn();
}

