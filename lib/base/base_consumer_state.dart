import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> with WidgetsBindingObserver {
  AppLocalizations get translation => AppLocalizations.of(context)!;
  Logger get log => Logger(T.toString());

  @override
  void initState() {
    log.info('$T initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    log.info('$T dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
