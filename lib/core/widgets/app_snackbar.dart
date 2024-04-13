import '../../pages/_app_exports.dart';

void showAppSnackBar(String text, BuildContext context, {bool isError = true}) {
  final snack = SnackBar(
    backgroundColor: AppColors.lightColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.all(0),
    margin: EdgeInsets.only(bottom: 90.h, left: 20.w, right: 20.w),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
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
          if (isError) ...[
            SvgPicture.asset(
              AssetPath.error,
              height: 20.h,
              // ignore: deprecated_member_use
              color: AppColors.errorColor,
            ),
            const SizedBox(width: 10),
          ],
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
