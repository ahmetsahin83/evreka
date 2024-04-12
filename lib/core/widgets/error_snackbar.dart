import '../../pages/_app_exports.dart';

void showErrorSnackBar(String text, BuildContext context) {
  final snack = SnackBar(
    backgroundColor: AppColors.lightColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(0),
    margin: const EdgeInsets.only(bottom: 90, left: 20, right: 20),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightColor,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColorOpacity,
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/Error.svg",
            height: 20,
            // ignore: deprecated_member_use
            color: AppColors.errorColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTextStyles.t1,
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snack);
}
