import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/tracking_repository.dart';

final trackingRepositoryProvider =
    Provider((ref) => TrackingRepository());

final driverProvider = Provider((ref) {
  return ref.read(trackingRepositoryProvider).getDriver();
});