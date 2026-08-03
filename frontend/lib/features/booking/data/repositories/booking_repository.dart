import '../models/truck_model.dart';

class BookingRepository {
  List<TruckModel> getAvailableTrucks() {
    return [
      TruckModel(
        id: "1",
        name: "Mini Truck",
        image: "",
        capacity: "800 KG",
        eta: "2 Hours",
        price: 1450,
        recommended: true,
      ),

      TruckModel(
        id: "2",
        name: "Pickup Truck",
        image: "",
        capacity: "1500 KG",
        eta: "3 Hours",
        price: 2350,
      ),

      TruckModel(
        id: "3",
        name: "Tata 407",
        image: "",
        capacity: "2500 KG",
        eta: "4 Hours",
        price: 3200,
      ),

      TruckModel(
        id: "4",
        name: "Container",
        image: "",
        capacity: "7000 KG",
        eta: "5 Hours",
        price: 6200,
      ),
    ];
  }
}