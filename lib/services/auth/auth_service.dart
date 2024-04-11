import 'dart:developer';

import '../../pages/_app_exports.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, bool>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user != null);
    } on FirebaseAuthException catch (e) {
      log('AuthService.signInWithEmailAndPassword: ${e.code}');
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else if (e.code == "invalid-credential") {
        return const Left('Invalid credential provided.');
      } else {
        return const Left('An error occurred while signing in.');
      }
    }
  }
}
