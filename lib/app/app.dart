import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:refresher/l10n/l10n.dart';
import 'package:refresher/services/hive_service.dart';
import 'package:refresher/utils/constants.dart';
import 'package:refresher/utils/router.dart';
import 'package:refresher/utils/singletons.dart';

class RefresherApp extends StatelessWidget {
  const RefresherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: Hive.box<dynamic>(
        RefresherConfig.instance!.values.globalHiveAuthBox,
      ).listenable(),
      builder: (context, _, __) {
        // At any time, the Auth-Dedicated Hive Box is listening,
        // So when the values change and the user is logged out,
        // the app automatically navigated to the sign in page on
        final isLoggedOut = getIt<HiveService>().isLoggedOut();
        Logger().e('isLoggedOut: $isLoggedOut');
        if (isLoggedOut) {
          getIt<RefresherRouter>().pushNamed(
            RefresherRouter.decisionRoute,
          );
        }

        return MaterialApp.router(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: getIt<RefresherRouter>().config(),
        );
      },
    );
  }
}
