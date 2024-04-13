import 'package:evreka/pages/_app_exports.dart';

import '../_core_exports.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.onChanged,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        onTapOutside: (final PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          labelStyle: AppTextStyles.t1,
          suffixIcon: suffixIcon,
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.shadowColorOpacity,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.shadowColorOpacity,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.yellow,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.darkGrey,
            ),
          ),
          labelText: labelText,
          contentPadding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: 1,
            bottom: 6.5.h,
          ),
          errorStyle: AppTextStyles.inputBoxLabelError,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
