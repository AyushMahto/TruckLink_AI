// class TruckModel {
//   final String id;
//   final String truckName;
//   final String image;
//   final double price;
//   final int capacity;
//   final String eta;

//   TruckModel({
//     required this.id,
//     required this.truckName,
//     required this.image,
//     required this.price,
//     required this.capacity,
//     required this.eta,
//   });
// }


class TruckModel {
  final String id;
  final String name;
  final String image;
  final String capacity;
  final String eta;
  final double price;
  final bool recommended;

  TruckModel({
    required this.id,
    required this.name,
    required this.image,
    required this.capacity,
    required this.eta,
    required this.price,
    this.recommended = false,
  });
}