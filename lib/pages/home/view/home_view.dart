import '../../_app_exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(41.0082, 28.9784), zoom: 15),
      ),
    );
  }
}
