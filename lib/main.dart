import 'dart:math';

import 'package:geodesy/geodesy.dart';

import 'pages/_app_exports.dart';

// late List<ContainerModel> locList;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  FirebaseAuth.instance.currentUser != null ? initialLocation = "/home" : initialLocation = "/";
  serviceLocator<HomeController>().greenMarker = await addCustomIcon("assets/icons/greenMarker.png");
  serviceLocator<HomeController>().yellowMarker = await addCustomIcon("assets/icons/yellowMarker.png");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: "Evreka",
      theme: appTheme,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

List<ContainerModel> generateRandomContainers(Location centerLocation, int count) {
  final List<ContainerModel> containers = [];

  final double centerLatitude = centerLocation.latitude;
  final double centerLongitude = centerLocation.longitude;
  final Random random = Random();
  for (int i = 0; i < count; i++) {
    final double latOffset = random.nextDouble() * 0.5;
    final double lngOffset = random.nextDouble() * 0.5;

    final double randomLat = centerLatitude + (random.nextBool() ? 2 : -5) * latOffset;
    final double randomLng = centerLongitude + (random.nextBool() ? 3 : -4) * lngOffset;

    final String containerId = 'Container ${i + 1}';
    final double occupancyRate = random.nextDouble() * 100;
    final String containerInformation = 'Information for Container ${i + 1}';
    final double containerTemperature = random.nextDouble() * 50;
    final DateTime dateOfDataReceived = DateTime.now().subtract(Duration(days: random.nextInt(30)));
    final String sensorId = 'Sensor ${random.nextInt(10)}';

    final ContainerModel container = ContainerModel(
      containerId: containerId,
      location: Location(latitude: randomLat, longitude: randomLng),
      occupancyRate: occupancyRate,
      containerInformation: containerInformation,
      containerTemperature: containerTemperature,
      dateOfDataReceived: dateOfDataReceived,
      sensorId: sensorId,
    );
    containers.add(container);
  }

  return containers;
}

// Future<void> addContainersToFirestore(List<ContainerModel> containers) async {
//   try {
//     // Firestore referansını al
//     final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers');

//     // Her bir konteyneri Firestore'a ekle
//     containers.forEach((container) async {
//       await containersRef.add({
//         'containerId': container.containerId,
//         'location': {
//           'latitude': container.location.latitude,
//           'longitude': container.location.longitude,
//         },
//         'occupancyRate': container.occupancyRate,
//         'containerInformation': container.containerInformation,
//         'containerTemperature': container.containerTemperature,
//         'dateOfDataReceived': container.dateOfDataReceived,
//         'sensorId': container.sensorId,
//       });
//     });

//     print('Containers added to Firestore successfully!');
//   } catch (e) {
//     print('Error adding containers to Firestore: $e');
//   }
// }

Future<BitmapDescriptor> addCustomIcon(String asset) async {
  return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(2, 2),
      ),
      asset);
}
