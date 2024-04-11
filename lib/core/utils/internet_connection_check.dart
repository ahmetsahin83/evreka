import 'package:evreka/pages/_app_exports.dart';

Future<bool> checkInternetConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}
