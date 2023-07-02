import 'package:firebase_auth/firebase_auth.dart';
import 'package:minha_estante/commom/models/user_model.dart';
import 'package:minha_estante/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verifica se o usuário é null para realizar o seu registro
      if (result.user != null) {
        return UserModel(
          // Faz a verificação do user no firebase
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verifica se o úsuario é null para realizar o login
      if (result.user != null) {
        await result.user!.updateDisplayName(name);

        String userID = result.user!.uid;

        await _firestore.collection('users').doc(userID).set({
          'nome': name,
          'email': email,
        });

        return UserModel(
          // Faz a verificação do user no firebase
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> recoverPwd({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
