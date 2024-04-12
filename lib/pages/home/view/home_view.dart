import '../../_app_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<HomeController>(
        init: HomeController(),
        id: "map",
        builder: (homeController) {
          if (homeController.selectedContainer != null) {
            if (homeController.isRelocating) {
              return Container(
                height: 170.h,
                width: MediaQuery.of(context).size.width - 20.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Please select a location from the map for your bin to be relocated. You can select a location by tapping on the map.",
                      style: AppTextStyles.t1,
                    ),
                    AppButton(
                      buttonText: "SAVE",
                      onPressed: () async => await homeController.relocateContainer(context),
                    ),
                  ],
                ),
              );
            }
            return Visibility(
              visible: homeController.selectedContainer != null && !homeController.isRelocating,
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
                height: 250.h,
                width: MediaQuery.of(context).size.width - 20.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Container ${homeController.selectedContainer!.containerId}",
                      style: AppTextStyles.h3,
                    ),
                    Text(
                      homeController.selectedContainer!.containerInformation,
                      style: AppTextStyles.h4,
                    ),
                    Text(
                      "Sensor ID: ${homeController.selectedContainer!.sensorId}",
                      style: AppTextStyles.t1,
                    ),
                    Text(
                      "Container Temperature: ${homeController.selectedContainer!.containerTemperature.toStringAsFixed(2)}",
                      style: AppTextStyles.t1,
                    ),
                    Text(
                      "Sensor data date: ${homeController.selectedContainer!.dateOfDataReceived.formattedDate}",
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
                            onPressed: () async => homeController.navigateToLocation(context),
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: AppButton(
                            buttonText: "RELOCATE",
                            onPressed: homeController.relocateButton,
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
        id: "map",
        builder: (homeController) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) async {
              homeController.mapController = controller;
              await homeController.onCameraIdle(context);
            },
            onCameraIdle: () async => await homeController.onCameraIdle(context),
            onTap: (LatLng latLng) async => await homeController.onTap(latLng),
            initialCameraPosition: const CameraPosition(target: LatLng(39.8974483, 32.7762401), zoom: 13),
            markers: homeController.markers ?? {},
          );
        },
      ),
    );
  }
}
