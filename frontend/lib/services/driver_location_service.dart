import 'dart:async';

import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class DriverLocationService {

  final LocationService service = LocationService();

  Timer? timer;

  void start(String truckId){

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) async {

        Position position = await Geolocator.getCurrentPosition();

        await service.updateTruckLocation(
          truckId,
          position.latitude,
          position.longitude,
        );

      },
    );

  }

  void stop(){
    timer?.cancel();
  }

}