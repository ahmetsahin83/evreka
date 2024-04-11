import '../_core_exports.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isDisable = false,
    this.width = 304,
  });

  final String buttonText;
  final bool isDisable;
  final double width;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorGreen,
            offset: Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      height: 43,
      width: width,
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          disabledBackgroundColor: AppColors.green.withOpacity(.3),
          elevation: 0,
          shadowColor: AppColors.shadowColorGreen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(buttonText, style: AppTextStyles.buttonTextStyle),
      ),
    );
  }
}
