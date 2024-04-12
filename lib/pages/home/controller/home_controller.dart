import 'package:evreka/pages/_app_exports.dart';

class HomeController extends GetxController {
  late GoogleMapController mapController;
  late LatLngBounds bounds;
  Set<Marker>? markers;
  late List<ContainerModel> nearbyContainers;

  BitmapDescriptor yellowMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor greenMarker = BitmapDescriptor.defaultMarker;

//servise taşı---------------------------------------------------
  Future<List<ContainerModel>> getNearbyContainers() async {
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

    print(nearbyContainers.length);

    return nearbyContainers;
  }
//servise taşı---------------------------------------------------
}
