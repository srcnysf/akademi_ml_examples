import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class AkademiMlKit extends StatelessWidget {
  const AkademiMlKit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Kit Examples',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [StackedService.routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
