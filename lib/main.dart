import 'package:flutter/material.dart';
import 'package:ml_kit_akademi_examples/app/ml_kit_akademi_example.dart';
import 'package:ml_kit_akademi_examples/core/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();

  runApp(const AkademiMlKit());
}
