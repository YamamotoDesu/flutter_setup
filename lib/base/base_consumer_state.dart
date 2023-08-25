import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseConsumer<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  AppLocalizations get translation => AppLocalizations.of(context)!;
  Logger get log => Logger(T.toString());

  @override
  void initState() {
    log.info('$T initState');
    super.initState();
  }

  @override
  void dispose() {
    log.info('$T dispose');
    super.dispose();
  }
}
