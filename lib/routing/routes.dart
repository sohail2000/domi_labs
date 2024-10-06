import 'package:domi_labs/features/home/presentation/map_screen_osm.dart';
import 'package:domi_labs/features/home/presentation/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = '/';
  static const pdfView = '/pdf_view';
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
              child: MapScreenOsm(),
            ),
          ),
          GoRoute(
            path: AppRoutes.pdfView,
            pageBuilder: (
              BuildContext context,
              GoRouterState state,
            ) =>
                NoTransitionPage(
              child: PdfView(
                url: state.extra as String,
              ),
            ),
          ),
        ],
      );
}
