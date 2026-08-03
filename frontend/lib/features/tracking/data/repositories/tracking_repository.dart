import '../models/driver_model.dart';

class TrackingRepository {
  DriverModel getDriver() {
    return DriverModel(
      name: "Rahul Sharma",
      phone: "+91 9876543210",
      truckNumber: "MH12AB4567",
      rating: 4.8,
    );
  }
}