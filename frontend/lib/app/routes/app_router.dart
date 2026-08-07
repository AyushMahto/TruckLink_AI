import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';

import '../../features/booking/presentation/screens/booking_success_screen.dart';
import '../../features/booking/presentation/screens/booking_summary_screen.dart';
import '../../features/booking/presentation/screens/search_truck_screen.dart';
import '../../features/booking/presentation/screens/truck_list_screen.dart';

import '../../features/customer/presentation/dashboard_screen.dart';
import '../../features/customer/presentation/screens/customer_dashboard.dart';

import '../../features/driver/presentation/screens/driver_dashboard.dart';
import '../../features/fleet/presentation/screens/fleet_dashboard.dart';

import '../../features/payment/presentation/screens/payment_failed_screen.dart';
import '../../features/payment/presentation/screens/payment_screen.dart';
import '../../features/payment/presentation/screens/payment_success_screen.dart';

import '../../features/role/presentation/role_selection_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/tracking/presentation/screens/tracking_screen.dart';

import '../../features/customer/presentation/screens/my_bookings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Login
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Signup
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          final role = state.uri.queryParameters['role'] ?? 'customer';

          return SignupScreen(
            role: role,
          );
        },
      ),

      // Role Selection
      GoRoute(
        path: '/role',
        builder: (context, state) => const RoleSelectionScreen(),
      ),

      // Search Truck
      GoRoute(
        path: '/search-truck',
        builder: (context, state) => const SearchTruckScreen(),
      ),

      // Truck List
      GoRoute(
        path: '/truck-list',
        builder: (context, state) => const TruckListScreen(),
      ),

      // Booking Summary
      GoRoute(
        path: '/booking-summary',
        builder: (context, state) {
          final truck = state.extra as Map<String, dynamic>;

          return BookingSummaryScreen(
            truck: truck,
          );
        },
      ),

      // Payment
      GoRoute(
        path: '/payment',
        builder: (context, state) {
          final amount = state.extra as double;

          return PaymentScreen(
            amount: amount,
          );
        },
      ),

      // Payment Success
      GoRoute(
        path: '/payment-success',
        builder: (context, state) => const PaymentSuccessScreen(),
      ),

      // Payment Failed
      GoRoute(
        path: '/payment-failed',
        builder: (context, state) => const PaymentFailedScreen(),
      ),

      // Booking Success
      GoRoute(
        path: '/booking-success',
        builder: (context, state) => const BookingSuccessScreen(),
      ),

      // Live Tracking
      GoRoute(
  path: '/tracking',
  builder: (context, state) {
    final booking = state.extra as Map<String, dynamic>;

    return TrackingScreen(
      booking: booking,
    );
  },
),
      // Customer Dashboard
      GoRoute(
        path: '/customer-dashboard',
        builder: (context, state) => const CustomerDashboard(),
      ),

      // Driver Dashboard
      GoRoute(
        path: '/driver-dashboard',
        builder: (context, state) => const DriverDashboard(),
      ),

      // Fleet Dashboard
      GoRoute(
        path: '/fleet-dashboard',
        builder: (context, state) => const FleetDashboard(),
      ),

      GoRoute(
  path: "/my-bookings",
  builder: (context, state) => const MyBookingsScreen(),
),

      // Old Dashboard
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}