import '../../_app_exports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  initState() {
    addCustomIcon("assets/icons/greenMarker.png");

    super.initState();
  }

  Set<Marker>? markers;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor greenIcon = BitmapDescriptor.defaultMarker;
  String selectedMarkerId = "";
  LatLng selectedLocation = const LatLng(41.0082, 28.9784);

  void addCustomIcon(String asset) {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(2, 2),
            ),
            asset)
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
          BitmapDescriptor.fromAssetImage(
                  const ImageConfiguration(
                    size: Size(2, 2),
                  ),
                  "assets/icons/yellowMarker.png")
              .then((value) => greenIcon = value);
          markers = Set.from(nearbyLocations.asMap().entries.map((entry) {
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
                  markers!.removeWhere((element) => element.markerId == MarkerId(index.toString()));
                  markers!.add(Marker(
                      markerId: MarkerId(index.toString()),
                      position: location,
                      infoWindow: InfoWindow(title: "Evreka $index"),
                      icon: greenIcon));
                });
              },
              icon: markerIcon,
            );
          }));
        });
      },
    );
  }

  List<LatLng> nearbyLocations = [
    const LatLng(41.0082, 28.9784),
    const LatLng(41.005, 28.974),
    const LatLng(41.003, 28.979),
    const LatLng(41.009, 28.980),
    const LatLng(41.010, 28.975),
    const LatLng(41.011, 28.977),
    const LatLng(41.007, 28.976),
    const LatLng(41.008, 28.980),
    const LatLng(41.009, 28.976),
    const LatLng(41.008, 28.975),
    const LatLng(41.009, 28.978),
    const LatLng(41.007, 28.980),
    const LatLng(41.006, 28.979),
    const LatLng(41.010, 28.977),
    const LatLng(41.004, 28.976),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: selectedMarkerId.isNotEmpty,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width - 20,
          color: Colors.white,
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(
        onTap: (LatLng latLng) {
          print("Tapped on: $latLng");
          if (selectedMarkerId.isNotEmpty) {
            markers!.removeWhere((element) => element.markerId == MarkerId(selectedMarkerId));
            markers!.add(Marker(
                markerId: MarkerId(selectedMarkerId),
                position: selectedLocation,
                infoWindow: InfoWindow(
                  title: "Evreka $selectedMarkerId",
                ),
                icon: markerIcon));

            selectedMarkerId = "";
          }
          setState(() {});
        },
        initialCameraPosition: const CameraPosition(target: LatLng(41.0082, 28.9784), zoom: 15),
        markers: markers ?? {},
      ),
    );
  }
}
