import 'package:domi_labs/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  // Global navigator key for accessing current context
  final navigatorKey = GlobalKey<NavigatorState>();

  // Init router here in order to be able to use it in the notification handler
  GoRouter router = AppRoutingUtils().buildGoRouter(navigatorKey);

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Domi Labs',
      debugShowCheckedModeBanner: true,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
