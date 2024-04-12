import '../../_app_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<HomeController>(
        init: HomeController(),
        id: "map",
        initState: (_) {},
        builder: (homeController) {
          if (homeController.selectedContainer != null) {
            return Visibility(
              visible: homeController.selectedContainer != null,
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
                      homeController.selectedContainer!.containerId,
                      style: AppTextStyles.h3,
                    ),
                    Text(
                      homeController.selectedContainer!.containerInformation,
                      style: AppTextStyles.h4,
                    ),
                    Text(
                      homeController.selectedContainer!.dateOfDataReceived.formattedDate,
                      style: AppTextStyles.t1,
                    ),
                    Text(
                      "Fullness Rate",
                      style: AppTextStyles.h4,
                    ),
                    Text(
                      "% ${homeController.selectedContainer!.occupancyRate.toStringAsFixed(2)}",
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
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        id: "map",
        builder: (homeController) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              homeController.mapController = controller;
              await homeController.onCameraIdle(context);
            },
            onCameraIdle: () async => await homeController.onCameraIdle(context),
            onTap: (LatLng latLng) async {
              if (homeController.selectedContainer != null) {
                homeController.markers!
                    .removeWhere((element) => element.markerId == MarkerId(homeController.selectedContainer!.containerId));
                homeController.markers!.add(Marker(
                    markerId: MarkerId(homeController.selectedContainer!.containerId),
                    position: LatLng(
                      homeController.selectedContainer!.location.latitude,
                      homeController.selectedContainer!.location.longitude,
                    ),
                    icon: homeController.yellowMarker));
                homeController.selectedContainer = null;
              }
              homeController.update(["map"]);
            },
            initialCameraPosition: const CameraPosition(target: LatLng(39.8974483, 32.7762401), zoom: 14),
            markers: homeController.markers ?? {},
          );
        },
      ),
    );
  }
}
