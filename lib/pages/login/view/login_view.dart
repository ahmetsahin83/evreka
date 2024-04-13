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
          child: Form(
            key: serviceLocator<LoginController>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SvgPicture.asset(
                  AssetPath.logo,
                  height: 30.h,
                ),
                SizedBox(height: 80.h),
                Text(
                  "Please enter your email and password.",
                  style: AppTextStyles.t2,
                ),
                SizedBox(height: 50.h),
                AppTextField(
                  focusNode: serviceLocator<LoginController>().focusNode,
                  onChanged: (final String value) {
                    serviceLocator<LoginController>().isEmailEmpty.value = value.isEmpty;
                    if (value.isEmail) {
                      serviceLocator<LoginController>().isValidateEmail.value = true;
                    } else {
                      serviceLocator<LoginController>().isValidateEmail.value = false;
                    }
                  },
                  labelText: "Email",
                  suffixIcon: Obx(
                    () => serviceLocator<LoginController>().isEmailError.value
                        ? SvgPicture.asset(
                            AssetPath.error,
                            colorFilter: const ColorFilter.mode(
                              AppColors.errorColor,
                              BlendMode.srcIn,
                            ),
                            fit: BoxFit.scaleDown,
                          )
                        : !serviceLocator<LoginController>().isEmailEmpty.value && serviceLocator<LoginController>().focusNode.hasFocus
                            ? GestureDetector(
                                onTap: () {
                                  serviceLocator<LoginController>().emailController.clear();
                                  serviceLocator<LoginController>().isEmailEmpty.value = true;
                                },
                                child: SvgPicture.asset(
                                  AssetPath.clear,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.darkGrey,
                                    BlendMode.srcIn,
                                  ),
                                  fit: BoxFit.scaleDown,
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                  validator: (final String? value) {
                    if (value!.isEmpty) {
                      serviceLocator<LoginController>().isEmailError.value = true;
                      return "Please enter your email.";
                    } else if (!value.isEmail) {
                      serviceLocator<LoginController>().isEmailError.value = true;

                      return "Please enter a valid email.";
                    }
                    serviceLocator<LoginController>().isEmailError.value = false;

                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: serviceLocator<LoginController>().emailController,
                ),
                SizedBox(height: 40.h),
                Obx(() => AppTextField(
                      labelText: "Password",
                      obscureText: !serviceLocator<LoginController>().isObscureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            serviceLocator<LoginController>().isObscureText.value = !serviceLocator<LoginController>().isObscureText.value;
                          },
                          child: SvgPicture.asset(
                            AssetPath.password,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              !serviceLocator<LoginController>().isObscureText.value ? AppColors.darkGrey : AppColors.yellow,
                              BlendMode.srcIn,
                            ),
                          )),
                      onChanged: (final String value) {
                        if (value.length >= 6) {
                          serviceLocator<LoginController>().isValidatePassword.value = true;
                        } else {
                          serviceLocator<LoginController>().isValidatePassword.value = false;
                        }
                      },
                      validator: (final String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your password.";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters.";
                        }
                        return null;
                      },
                      controller: serviceLocator<LoginController>().passwordController,
                    )),
                const Spacer(),
                Obx(() => AppButton(
                      buttonText: "LOGIN",
                      isDisable: !(serviceLocator<LoginController>().isValidatePassword.value &&
                          serviceLocator<LoginController>().isValidateEmail.value),
                      onPressed: () => serviceLocator<LoginController>().login(context),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
