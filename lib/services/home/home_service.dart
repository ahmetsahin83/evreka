import '../../pages/_app_exports.dart';

class HomeService {
  Future<Either<String, List<ContainerModel>>> getNearbyContainers(LatLngBounds bounds) async {
    try {
      final CollectionReference containersRef = FirebaseFirestore.instance.collection('containers');

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

      return Right(nearbyContainers);
    } catch (e) {
      if (await checkInternetConnection()) {
        return const Left('Check your internet connection.');
      }
      return const Left('An error occurred while fetching nearby containers.');
    }
  }
}
