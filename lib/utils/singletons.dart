import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:refresher/features/auth/cubit/sign_in_cubit.dart';
import 'package:refresher/services/auth_service.dart';
import 'package:refresher/services/hive_service.dart';
import 'package:refresher/utils/router.dart';

final getIt = GetIt.instance;

class Singletons {
  static void setup() {
    getIt
      ..registerSingleton<RefresherRouter>(RefresherRouter())
      ..registerSingleton<HiveService>(HiveServiceImpl())
      ..registerSingleton<AuthService>(AuthServiceImpl());
  }

  static List<BlocProvider> registerCubits() => [
        BlocProvider<SigninCubit>(
          create: (context) => SigninCubit(
            authService: getIt(),
            hiveService: getIt(),
          ),
        ),
      ];
}
