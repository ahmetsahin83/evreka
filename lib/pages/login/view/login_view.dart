import 'package:evreka/core/utils/service_locator.dart';
import 'package:flutter_svg/svg.dart';

import '../../_app_exports.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  BoxDecoration get _bgDecoration => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.scaffoldBackground,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: _bgDecoration,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                "assets/icons/Logo.svg",
                height: 30,
              ),
              const SizedBox(height: 80),
              Text(
                "Please enter your user name and password.",
                style: AppTextStyles.t2,
              ),
              const SizedBox(height: 50),
              AppTextField(
                labelText: "Username",
                controller: serviceLocator<LoginController>().emailController,
              ),
              const SizedBox(height: 40),
              AppTextField(
                labelText: "Password",
                controller: serviceLocator<LoginController>().passwordController,
              ),
              const Spacer(),
              AppButton(
                buttonText: "Login",
                onPressed: () => serviceLocator<LoginController>().login(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
