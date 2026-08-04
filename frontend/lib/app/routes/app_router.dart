
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/role/presentation/role_selection_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/customer/presentation/dashboard_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/booking/presentation/screens/search_truck_screen.dart';
import '../../features/booking/presentation/screens/truck_list_screen.dart';
import '../../features/booking/presentation/screens/booking_summary_screen.dart';
import '../../features/booking/presentation/screens/payment_screen.dart';
import '../../features/booking/presentation/screens/booking_success_screen.dart';
import '../../features/tracking/presentation/screens/tracking_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      // GoRoute(
      //   path: '/signup',
      //   builder: (context, state) => const SignupScreen(),
      // ),
      GoRoute(
      path: '/signup',
      builder: (context, state) {
      final role = state.uri.queryParameters['role'] ?? 'customer';

      return SignupScreen(
      role: role,
      );
      },
      ),

      GoRoute(
      path: '/role',
      builder: (context, state) => const RoleSelectionScreen(),
      ),

      GoRoute(
      path: '/search-truck',
      builder: (context, state) => const SearchTruckScreen(),
      ),

      GoRoute(
      path: '/truck-list',
      builder: (context, state) => const TruckListScreen(),
      ),

      GoRoute(
      path: '/booking-summary',
      builder: (context, state) => const BookingSummaryScreen(),
      ),

      GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
      ),

      GoRoute(
      path: '/booking-success',
      builder: (context, state) => const BookingSuccessScreen(),
      ),

      GoRoute(
      path: '/tracking',
      builder: (context, state) => const TrackingScreen(),
      ),

      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}
