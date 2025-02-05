import 'package:auto_route/auto_route.dart';
import 'package:refresher/utils/router.gr.dart';

@AutoRouterConfig()
class RefresherRouter extends $RefresherRouter {
  // Auth
  static const String decisionRoute = '/';
  static const String signInRoute = '/sign-in';
  static const String landingRoute = '/landing';
  static const String debriefNotesRoute = '/debrief-notes';

  @override
  List<AutoRoute> get routes => [
        // Auth
        AutoRoute(page: DecisionRoute.page, path: decisionRoute),
        AutoRoute(page: SignInRoute.page, path: signInRoute),

        // Home
        AutoRoute(
          page: LandingRoute.page,
          path: landingRoute,
        ),
        AutoRoute(
          page: DebriefNotesRoute.page,
          path: debriefNotesRoute,
        ),
      ];
}
