import '../../_app_exports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  initState() {
    super.initState();
  }
  //TODO: CUSTOM İCONU FARKLI YERDE HALLET. BURADA SADECE MARKERLARI EKLE

  String selectedMarkerId = "";
  LatLng selectedLocation = const LatLng(41.0082, 28.9784);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<HomeController>(
        init: HomeController(),
        id: "map",
        initState: (_) {},
        builder: (homeController) {
          return Visibility(
            visible: selectedMarkerId.isNotEmpty,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
              height: 230,
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Container 8215124",
                    style: AppTextStyles.h3,
                  ),
                  Text(
                    "Next Collection",
                    style: AppTextStyles.h4,
                  ),
                  Text(
                    "12.01.2020",
                    style: AppTextStyles.t1,
                  ),
                  Text(
                    "Fullness Rate",
                    style: AppTextStyles.h4,
                  ),
                  Text(
                    "%50",
                    style: AppTextStyles.t1,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: AppButton(
                          buttonText: "NAVIGATE",
                          onPressed: () {},
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                      const SizedBox(width: 22),
                      Expanded(
                        child: AppButton(
                          buttonText: "RELOCATE",
                          onPressed: () {},
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (homeController) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              homeController.mapController = controller;
              homeController.bounds = await controller.getVisibleRegion();
              homeController.nearbyContainers = await homeController.getNearbyContainers();
              //---
              List<LatLng> nearbyLocations =
                  serviceLocator<HomeController>().nearbyContainers.map((e) => LatLng(e.location.latitude, e.location.longitude)).toList();
              serviceLocator<HomeController>().markers = Set.from(
                nearbyLocations.asMap().entries.map(
                  (entry) {
                    int index = entry.key;
                    LatLng location = entry.value;
                    return Marker(
                      markerId: MarkerId(index.toString()),
                      position: location,
                      infoWindow: InfoWindow(title: "Evreka $index"),
                      onTap: () {
                        print("Marker $index tapped");
                        selectedMarkerId = index.toString();
                        selectedLocation = location;
                        setState(() {
                          serviceLocator<HomeController>()
                              .markers!
                              .removeWhere((element) => element.markerId == MarkerId(index.toString()));
                          serviceLocator<HomeController>().markers!.add(Marker(
                              markerId: MarkerId(index.toString()),
                              position: location,
                              infoWindow: InfoWindow(title: "Evreka $index"),
                              icon: homeController.greenMarker));
                        });
                      },
                      icon: homeController.yellowMarker,
                    );
                  },
                ),
              );
            },
            onCameraIdle: () async {
              print(await homeController.mapController.getVisibleRegion());
              homeController.bounds = await homeController.mapController.getVisibleRegion();
              //----

              homeController.nearbyContainers = await homeController.getNearbyContainers();
              //---
              List<LatLng> nearbyLocations =
                  serviceLocator<HomeController>().nearbyContainers.map((e) => LatLng(e.location.latitude, e.location.longitude)).toList();
              serviceLocator<HomeController>().markers = Set.from(
                nearbyLocations.asMap().entries.map(
                  (entry) {
                    int index = entry.key;
                    LatLng location = entry.value;
                    return Marker(
                      markerId: MarkerId(index.toString()),
                      position: location,
                      onTap: () {
                        print("Marker $index tapped");
                        selectedMarkerId = index.toString();
                        selectedLocation = location;
                        setState(() {
                          serviceLocator<HomeController>()
                              .markers!
                              .removeWhere((element) => element.markerId == MarkerId(index.toString()));
                          serviceLocator<HomeController>()
                              .markers!
                              .add(Marker(markerId: MarkerId(index.toString()), position: location, icon: homeController.greenMarker));
                        });
                      },
                      icon: homeController.yellowMarker,
                    );
                  },
                ),
              );
              setState(() {});
            },
            onTap: (LatLng latLng) async {
              print("Tapped on: $latLng");
              if (selectedMarkerId.isNotEmpty) {
                homeController.markers!.removeWhere((element) => element.markerId == MarkerId(selectedMarkerId));
                homeController.markers!
                    .add(Marker(markerId: MarkerId(selectedMarkerId), position: selectedLocation, icon: homeController.yellowMarker));
                selectedMarkerId = "";
              }
              setState(() {});
            },
            initialCameraPosition: const CameraPosition(target: LatLng(39.8974483, 32.7762401), zoom: 14),
            markers: homeController.markers ?? {},
          );
        },
      ),
    );
  }
}
