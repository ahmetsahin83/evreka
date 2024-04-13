import 'package:evreka/pages/_app_exports.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => AuthService());
  serviceLocator.registerLazySingleton(() => OperationService());

  final loginController = Get.put(LoginController());

  serviceLocator.registerLazySingleton(() => loginController);

  final operationController = Get.put(OperationController());

  serviceLocator.registerLazySingleton(() => operationController);
}
