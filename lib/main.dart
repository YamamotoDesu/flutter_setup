import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/flavor/flavor.dart';
import 'package:flutter_setup/core/env/env_reader.dart';
import 'package:flutter_setup/core/providers/internet_connection_observer.dart';
import 'package:flutter_setup/main_widget.dart';

FutureOr<void> mainApp(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
  final container = ProviderContainer();

  // Observer Internet Connection
  container.read(internetConnectionObserverProvider);

  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainWidget(),
    ),
  );
}
