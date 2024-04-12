// ignore_for_file: use_build_context_synchronously

import 'package:evreka/pages/_app_exports.dart';

class HomeController extends GetxController {
  late GoogleMapController mapController;
  late LatLngBounds bounds;
  Set<Marker>? markers;
  List<ContainerModel>? nearbyContainers;

  ContainerModel? selectedContainer;
  ContainerModel? relocatedContainer;

  BitmapDescriptor yellowMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor lightYellowMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor greenMarker = BitmapDescriptor.defaultMarker;

  bool isRelocating = false;

  final HomeService _homeService = serviceLocator<HomeService>();

  getNearbyContainers(BuildContext context) async {
    final result = await _homeService.getNearbyContainers(bounds);

    result.fold((left) => showAppSnackBar(left, context), (right) {
      nearbyContainers = right;
    });
  }

  Future<void> onCameraIdle(BuildContext context) async {
    if (!isRelocating) {
      bounds = await mapController.getVisibleRegion();
      await getNearbyContainers(context);
      if (nearbyContainers != null) {
        markers = Set.from(nearbyContainers!.asMap().entries.map((container) {
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
  }

  Future<void> onTap(LatLng latLng) async {
    if (selectedContainer != null && !isRelocating) {
      markers!.removeWhere((element) => element.markerId == MarkerId(selectedContainer!.containerId));
      markers!.add(Marker(
          markerId: MarkerId(selectedContainer!.containerId),
          position: LatLng(
            selectedContainer!.location.latitude,
            selectedContainer!.location.longitude,
          ),
          icon: yellowMarker));
      selectedContainer = null;
    } else if (isRelocating) {
      relocatedContainer!.location = LocationModel(latitude: latLng.latitude, longitude: latLng.longitude);
      markers!.add(Marker(markerId: MarkerId("${relocatedContainer!.containerId}new"), position: latLng, icon: yellowMarker));
    }
    update(["map"]);
  }

  void relocateButton() {
    isRelocating = true;
    relocatedContainer = selectedContainer;
    markers!.clear();
    markers!.add(Marker(
        markerId: MarkerId(selectedContainer!.containerId),
        position: LatLng(
          selectedContainer!.location.latitude,
          selectedContainer!.location.longitude,
        ),
        icon: lightYellowMarker));

    update(["map"]);
  }

  Future<void> relocateContainer(BuildContext context) async {
    final result = await _homeService.relocateContainer(relocatedContainer!);

    result.fold(
      (left) => showAppSnackBar(left, context),
      (right) async {
        showAppSnackBar('Your bin has been relocated successfully!', context, isError: false);
        isRelocating = false;
        relocatedContainer = null;
        selectedContainer = null;
        markers!.clear();
        await onCameraIdle(context);
        update(["map"]);
      },
    );
  }

  Future<void> navigateToLocation(BuildContext context) async {
    final double latitude = selectedContainer!.location.latitude;
    final double longitude = selectedContainer!.location.longitude;
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      showAppSnackBar("An error occured while trying to open Google Maps!", context);
    }
  }
}
