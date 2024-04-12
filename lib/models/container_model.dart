import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evreka/models/location_model.dart';

class ContainerModel {
  final String containerId;
  LocationModel location;
  final double occupancyRate;
  final String containerInformation;
  final double containerTemperature;
  final DateTime dateOfDataReceived;
  final String sensorId;

  ContainerModel({
    required this.containerId,
    required this.location,
    required this.occupancyRate,
    required this.containerInformation,
    required this.containerTemperature,
    required this.dateOfDataReceived,
    required this.sensorId,
  });

  factory ContainerModel.fromMap(Map<String, dynamic> map) {
    return ContainerModel(
      containerId: map['containerId'],
      location: LocationModel.fromMap(map['location']),
      occupancyRate: map['occupancyRate'],
      containerInformation: map['containerInformation'],
      containerTemperature: map['containerTemperature'],
      dateOfDataReceived: (map['dateOfDataReceived'] as Timestamp).toDate(),
      sensorId: map['sensorId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'containerId': containerId,
      'location': location.toMap(),
      'occupancyRate': occupancyRate,
      'containerInformation': containerInformation,
      'containerTemperature': containerTemperature,
      'dateOfDataReceived': dateOfDataReceived,
      'sensorId': sensorId,
    };
  }
}
