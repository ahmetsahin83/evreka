// ignore_for_file: use_build_context_synchronously

import 'package:evreka/pages/_app_exports.dart';

class HomeController extends GetxController {
  late GoogleMapController mapController;
  late LatLngBounds bounds;
  Set<Marker>? markers;
  late List<ContainerModel> nearbyContainers;

  ContainerModel? selectedContainer;

  BitmapDescriptor yellowMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor greenMarker = BitmapDescriptor.defaultMarker;

  final HomeService _homeService = serviceLocator<HomeService>();

  getNearbyContainers(BuildContext context) async {
    final result = await _homeService.getNearbyContainers(bounds);

    result.fold((left) => showErrorSnackBar(left, context), (right) {
      nearbyContainers = right;
    });
  }

  Future<void> onCameraIdle(BuildContext context) async {
    bounds = await mapController.getVisibleRegion();
    await getNearbyContainers(context);
    markers = Set.from(nearbyContainers.asMap().entries.map((container) {
      String id = container.value.containerId;
      LatLng location = LatLng(container.value.location.latitude, container.value.location.longitude);
      return Marker(
        markerId: MarkerId(id.toString()),
        position: location,
        onTap: () {
          selectedContainer = container.value;
          update(["map"]);
          markers!.removeWhere((element) => element.markerId == MarkerId(id));
          markers!.add(Marker(
            markerId: MarkerId(id),
            position: location,
            icon: yellowMarker,
          ));
        },
        icon: greenMarker,
      );
    }));
    if (selectedContainer != null) {
      markers!.removeWhere((element) => element.markerId == MarkerId(selectedContainer!.containerId));
      markers!.add(Marker(
        markerId: MarkerId(selectedContainer!.containerId),
        position: LatLng(
          selectedContainer!.location.latitude,
          selectedContainer!.location.longitude,
        ),
        icon: yellowMarker,
      ));
    }
    update(["map"]);
  }
}
