import 'pages/_app_exports.dart';

// late List<ContainerModel> locList;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.currentUser != null ? initialLocation = "/home" : initialLocation = "/";
  setupServiceLocator();
  serviceLocator<HomeController>().greenMarker = await addCustomIcon(AssetPath.greenMarker);
  serviceLocator<HomeController>().yellowMarker = await addCustomIcon(AssetPath.yellowMarker);
  serviceLocator<HomeController>().lightYellowMarker = await addCustomIcon(AssetPath.lightYellowMarker);

  //generate containers in firebase database
  // final homeService = serviceLocator<HomeService>();
  // homeService
  //     .addContainersToFirestore(homeService.generateRandomContainers(LocationModel(latitude: 39.8974483, longitude: 32.7762401), 1500));

  await SentryFlutter.init((options) {
    options.dsn = 'https://a8041bd423e8f2697a93561440b50702@o4507075211165696.ingest.de.sentry.io/4507075212410960';
    options.tracesSampleRate = 1.0;
    options.profilesSampleRate = 1.0;
  }, appRunner: () => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 740),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp.router(
            title: "Evreka",
            theme: appTheme,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
        });
  }
}

Future<BitmapDescriptor> addCustomIcon(String asset) async {
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: Size(48, 48)),
    asset,
  );
}
