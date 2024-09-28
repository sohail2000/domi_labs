import 'package:domi_labs/features/home/presentation/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = '/';
}

class AppRoutingUtils {
  GoRouter buildGoRouter(GlobalKey<NavigatorState> navigatorKey) => GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: AppRoutes.home,
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (
              BuildContext context,
              GoRouterState state,
            ) =>
                const NoTransitionPage(
              child: MapScreen(),
            ),
          ),
          
        ],
      );
}