import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/truck_model.dart';
import '../data/repositories/booking_repository.dart';

final bookingRepositoryProvider =
    Provider((ref) => BookingRepository());

final truckListProvider = Provider<List<TruckModel>>((ref) {
  return ref.read(bookingRepositoryProvider).getAvailableTrucks();
});