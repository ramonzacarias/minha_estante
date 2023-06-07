import '../commom/models/user_model.dart';

// Interface para a autenticação do usuario

abstract class AuthService {
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
  
  Future<void> recoverPwd({
    required String email,
  });
}
