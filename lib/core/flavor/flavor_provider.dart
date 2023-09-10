import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_setup/core/flavor/flavor.dart';

final flavorProvider = StateProvider<Flavor>((ref) => Flavor.dev);
