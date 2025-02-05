import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:refresher/models/adapters.dart';
import 'package:refresher/models/auth.dart';
import 'package:refresher/utils/constants.dart';

abstract class HiveService {
  Future<void> initBoxes();
  void clearPrefs();
  void clearBox();

  void persistToken(String token);
  String? retrieveToken();
  bool isLoggedOut();

  void persistUser(RefresherUser user);
  RefresherUser? retrieveUser();
}

class HiveServiceImpl implements HiveService {
  @override
  Future<void> initBoxes() async {
    await Hive.initFlutter();

    Hive
          ..registerAdapter(RefresherUserAdapter())
          ..registerAdapter(
            SignInDTOAdapter(),
          ) // Here for adapter registration demo completeness
        ;

    await Hive.openBox<dynamic>(
      RefresherConfig.instance!.values.globalHiveAuthBox,
    );
    await Hive.openBox<dynamic>(RefresherConfig.instance!.values.opsBox);
  }

  @override
  void clearPrefs() {
    Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox)
        .deleteAll(<String>[
      'accessToken',
      'profile',
      'classGroups',
      'studentCredentials',
    ]);
  }

  @override
  void clearBox() {
    Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox).clear();
  }

  @override
  void persistToken(String token) {
    Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox).put(
      'tokenExpiryTime',
      DateTime.now()
          .add(
            const Duration(
              // days: 3,
              seconds: 10,
            ),
          )
          .toString(),
    );

    Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox)
        .put('accessToken', token);

    Hive.box<dynamic>(RefresherConfig.instance!.values.globalHiveAuthBox)
        .put('isLoggedOut', false);
  }

  @override
  String? retrieveToken() {
    final box = Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox);
    final accessToken = box.get('accessToken') as String?;
    if (accessToken == null) return null;

    final expiryTime = box.get('tokenExpiryTime') as String?;
    if (expiryTime == null) return null;

    final expiry = DateTime.parse(expiryTime);
    if (DateTime.now().isAfter(expiry)) {
      clearPrefs();
      Hive.box<dynamic>(RefresherConfig.instance!.values.globalHiveAuthBox)
          .put('isLoggedOut', true);
      return null;
    }

    return accessToken;
  }

  @override
  bool isLoggedOut() {
    return Hive.box<dynamic>(
          RefresherConfig.instance!.values.globalHiveAuthBox,
        ).get('isLoggedOut') as bool? ??
        false;
  }

  @override
  void persistUser(RefresherUser user) {
    Logger().i('Persisting user: $user');
    Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox)
        .put('user', user);
  }

  @override
  RefresherUser? retrieveUser() {
    final box = Hive.box<dynamic>(RefresherConfig.instance!.values.opsBox);
    return box.get('user') as RefresherUser?;
  }
}
