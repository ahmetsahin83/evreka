import 'package:evreka/pages/_app_exports.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  final loginController = Get.put(LoginController());

  serviceLocator.registerLazySingleton(() => loginController);
}
