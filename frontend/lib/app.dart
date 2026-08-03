import 'package:flutter/material.dart';

import 'app/routes/app_router.dart';
import 'app/theme/app_theme.dart';

class TruckLinkAIApp extends StatelessWidget {
  const TruckLinkAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "TruckLink AI",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
