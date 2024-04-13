import 'dart:math';

import '../../pages/_app_exports.dart';

class OperationService {
  Future<Either<String, List<ContainerModel>>> getNearbyContainers(LatLngBounds bounds) async {
    try {
      final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers3');

      double minLat = bounds.southwest.latitude;
      double maxLat = bounds.northeast.latitude;
      double minLng = bounds.southwest.longitude;
      double maxLng = bounds.northeast.longitude;

      final QuerySnapshot querySnapshot = await containersRef
          .where("location.latitude", isGreaterThanOrEqualTo: minLat)
          .where("location.latitude", isLessThanOrEqualTo: maxLat)
          .where("location.longitude", isGreaterThanOrEqualTo: minLng)
          .where("location.longitude", isLessThanOrEqualTo: maxLng)
          .get();

      final List<ContainerModel> nearbyContainers = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        ContainerModel container = ContainerModel.fromMap(data);
        return container;
      }).toList();
      debugPrint('nearby containers: ${nearbyContainers.length}');
      return Right(nearbyContainers);
    } catch (e) {
      if (!await checkInternetConnection()) {
        return const Left('Check your internet connection.');
      }
      await Sentry.captureException(e, stackTrace: e);
      debugPrint('Error: $e');
      return const Left('An error occurred!');
    }
  }

  Future<Either<String, bool>> relocateContainer(ContainerModel container) async {
    try {
      final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers3');
      await containersRef.doc("Container ${container.containerId}").update(container.toMap());
      debugPrint('relocated successfully');
      return const Right(true);
    } catch (e) {
      debugPrint('Error: $e');
      if (!await checkInternetConnection()) {
        return const Left('Check your internet connection.');
      }
      await Sentry.captureException(e, stackTrace: e);
      return const Left('An error occurred while relocating the container.');
    }
  }

  Stream<ContainerModel> getContainerInformation(int containerId) {
    final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers3');
    return containersRef.doc('Container $containerId').snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ContainerModel.fromMap(data);
    });
  }
  // used for once to generate random containers and add them to firestore

  List<ContainerModel> generateRandomContainers(LocationModel centerLocation, int count) {
    final List<ContainerModel> containers = [];

    final double centerLatitude = centerLocation.latitude;
    final double centerLongitude = centerLocation.longitude;
    final Random random = Random();
    for (int i = 0; i < count; i++) {
      final double latOffset = random.nextDouble() * 0.5;
      final double lngOffset = random.nextDouble() * 0.5;

      final double randomLat = centerLatitude + (random.nextBool() ? 2 : -4) * latOffset;
      final double randomLng = centerLongitude + (random.nextBool() ? 3 : -3) * lngOffset;

      final String containerId = '${i + 1}';
      final double occupancyRate = random.nextDouble() * 100;
      final String containerInformation = 'Information for Container ${i + 1}';
      final double containerTemperature = random.nextDouble() * 50;
      final DateTime dateOfDataReceived = DateTime.now().subtract(Duration(days: random.nextInt(30)));
      final String sensorId = 'Sensor ${random.nextInt(10)}';

      final ContainerModel container = ContainerModel(
        containerId: containerId,
        location: LocationModel(latitude: randomLat, longitude: randomLng),
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

  Future<void> addContainersToFirestore(List<ContainerModel> containers) async {
    try {
      final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers3');

      for (var container in containers) {
        await containersRef.doc("Container ${container.containerId}").set(container.toMap());
      }

      debugPrint('added successfully');
    } catch (e) {
      await Sentry.captureException(e, stackTrace: e);
      debugPrint('Error: $e');
    }
  }
}
