// ignore_for_file: use_build_context_synchronously

import 'package:evreka/pages/_app_exports.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    if (await checkInternetConnection() == false) {
      return showAppSnackBar(
        "Please check your internet connection.",
        context,
      );
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => const CupertinoActivityIndicator(
        radius: 10,
        color: Colors.white,
      ),
      barrierDismissible: false,
    );
    final Either<String, bool> result = await _authService.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    result.fold(
      (String error) {
        Navigator.of(context).pop();
        showAppSnackBar(
          error,
          context,
        );
      },
      (bool success) {
        context.goNamed("home");
      },
    );
  }
}
