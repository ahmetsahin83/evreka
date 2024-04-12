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
          padding: EdgeInsets.all(30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                "assets/icons/Logo.svg",
                height: 30.h,
              ),
              SizedBox(height: 80.h),
              Text(
                "Please enter your user name and password.",
                style: AppTextStyles.t2,
              ),
              SizedBox(height: 50.h),
              AppTextField(
                labelText: "Username",
                controller: serviceLocator<LoginController>().emailController,
              ),
              SizedBox(height: 40.h),
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
