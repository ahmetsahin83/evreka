import '../_core_exports.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.labelText, required this.controller});

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,

      child: TextFormField(
        controller: controller,
        onTapOutside: (final PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.shadowColorOpacity,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.yellow,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.yellow,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.darkGrey,
            ),
          ),
          labelText: labelText,
          contentPadding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: 1,
            bottom: 6.5,
          ),
          errorStyle: AppTextStyles.inputBoxLabelError,
          // error: SvgPicture.asset(
          //   'assets/icons/Error.svg',
          //   width: 16,
          //   height: 16,
          //   color: AppColors.errorColor,
          // ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.errorColor,
            ),
          ),
        ),
      ),
    );
  }
}

// class AppTextField extends StatelessWidget {
//   // Dependencies
//   final TextEditingController? controller;
//   final String? hintText;
//   final double width;
//   final Function(String)? onSubmitted;
//   final Function(String)? onChanged;
//   final Widget? suffixIcon;
//   final Widget? suffix;
//   final Widget? prefixIcon;
//   final Widget? prefix;
//   final String? Function(String?)? validator;
//   final int? minLines;
//   final int maxLines;
//   final TextInputType? keyboardType;
//   final FocusNode? focusNode;
//   final bool autoFocus;
//   final TextInputAction? textInputAction;
//   final TextCapitalization textCapitalization;
//   final bool readOnly;
//   final Function()? onTap;
//   final bool obscureText;
//   final EdgeInsets? contentPadding;
//   final EdgeInsets scrollPadding;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool isFilled;
//   final Color? fillColor;
//   final String? labelText;
//   final Color? labelTextColor;
//   final TextStyle? textStyle;
//   final InputBorder? inputBorder;
//   final String? initialValue;
//   final BoxConstraints? prefixIconConstraints;

//   // Contructor
//   const AppTextField({
//     Key? key,
//     this.controller,
//     this.hintText,
//     this.width = double.infinity,
//     this.onSubmitted,
//     this.onChanged,
//     this.suffixIcon,
//     this.suffix,
//     this.prefixIcon,
//     this.prefix,
//     this.validator,
//     this.minLines,
//     this.maxLines = 1,
//     this.keyboardType,
//     this.focusNode,
//     this.autoFocus = false,
//     this.textInputAction = TextInputAction.search,
//     this.textCapitalization = TextCapitalization.none,
//     this.readOnly = false,
//     this.onTap,
//     this.obscureText = false,
//     this.contentPadding,
//     this.scrollPadding = const EdgeInsets.all(20.0),
//     this.inputFormatters,
//     this.isFilled = false,
//     this.fillColor,
//     this.labelText,
//     this.labelTextColor,
//     this.textStyle,
//     this.inputBorder,
//     this.initialValue,
//     this.prefixIconConstraints,
//   }) : super(key: key);

//   // Widget
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: AppScale.buttonHeight,
//       width: width,
//       child: TextFormField(
//         controller: controller,
//         initialValue: initialValue,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: AppTextStyles.body1Semibold.copyWith(
//             color: AppColors.greyFifth,
//           ),
//           labelText: labelText,
//           labelStyle: AppTextStyles.body1Semibold.copyWith(
//             color: AppColors.greySeventh,
//           ),
//           floatingLabelStyle: AppTextStyles.body2Semibold.copyWith(
//             color: AppColors.textSecond,
//           ),
//           contentPadding: contentPadding ??
//               EdgeInsets.symmetric(
//                 horizontal: AppScale.getWidth(16),
//                 vertical: AppScale.getHeight(16),
//               ),
//           suffixIcon: suffixIcon,
//           suffix: suffix,
//           suffixIconConstraints: BoxConstraints(
//             maxWidth: AppScale.getWidth(100),
//             maxHeight: AppScale.getWidth(24),
//           ),
//           prefixIcon: prefixIcon,
//           prefix: prefix,
//           prefixIconConstraints: BoxConstraints(
//             maxWidth: AppScale.getWidth(100),
//             maxHeight: AppScale.getWidth(24),
//           ),
//           border: inputBorder ??  OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColors.greyFifth,
//             ),
//             borderRadius: BorderRadius.circular(
//               AppScale.getHeight(16),
//             ),
//           ),
//           focusedBorder: inputBorder ?? OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColors.greyFifth,
//             ),
//             borderRadius: BorderRadius.circular(
//               AppScale.getHeight(16),
//             ),
//           ),
//           enabledBorder: inputBorder ?? OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: AppColors.greyFifth,
//             ),
//             borderRadius: BorderRadius.circular(
//               AppScale.getHeight(16),
//             ),
//           ),
//           filled: isFilled,
//           fillColor: fillColor,          
//         ),
//         style: textStyle ?? AppTextStyles.body1Semibold,
//         scrollPadding: scrollPadding,
//         onFieldSubmitted: onSubmitted,
//         onChanged: onChanged,
//         validator: validator,
//         keyboardType: keyboardType,
//         minLines: minLines,
//         maxLines: maxLines,
//         focusNode: focusNode,
//         autofocus: autoFocus,
//         textInputAction: textInputAction,
//         textCapitalization: textCapitalization,
//         readOnly: readOnly,
//         onTap: onTap,
//         obscureText: obscureText,
//         inputFormatters: inputFormatters,
//         onTapOutside: (final PointerDownEvent event) {
//           FocusManager.instance.primaryFocus?.unfocus();
//         },
//       ),
//     );
//   }
// }
