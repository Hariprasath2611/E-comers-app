import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/products/presentation/screens/home_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/wishlist_screen.dart';
import '../../features/profile/presentation/screens/order_history_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/checkout/presentation/screens/order_success_screen.dart';
import '../../features/admin/presentation/screens/admin_login_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_products_screen.dart';
import '../../features/admin/presentation/screens/admin_orders_screen.dart';
import '../../features/admin/presentation/widgets/admin_scaffold.dart';
import '../widgets/scaffold_with_navbar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/product/:id',
      parentNavigatorKey: _rootNavigatorKey, // Hide bottom nav
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/checkout',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/order-success',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OrderSuccessScreen(),
    ),
    GoRoute(
      path: '/orders',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    
    // Admin Routes
    GoRoute(
      path: '/admin/login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return AdminScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/products',
          builder: (context, state) => const AdminProductsScreen(),
        ),
        GoRoute(
          path: '/admin/orders',
          builder: (context, state) => const AdminOrdersScreen(),
        ),
      ],
    ),
  ],
);
