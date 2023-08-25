import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  AppLocalizations get translation => AppLocalizations.of(context)!;
  Logger get log => Logger(T.toString());

  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  void init() {}

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
