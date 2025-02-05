import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresher/app/app.dart';
import 'package:refresher/bootstrap.dart';
import 'package:refresher/utils/constants.dart';
import 'package:refresher/utils/singletons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RefresherConfig(
    values: RefresherValues(
      opsBox: 'prf-super-app-{random-key}-dev',
      baseDomain: 'prf-sockets.test',
      urlScheme: 'http',
    ),
  );

  await bootstrap(
    () => MultiBlocProvider(
      providers: Singletons.registerCubits(),
      child: const RefresherApp(),
    ),
  );
}
