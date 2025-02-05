import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:refresher/services/hive_service.dart';
import 'package:refresher/utils/router.dart';
import 'package:refresher/utils/singletons.dart';

@RoutePage()
class DecisionPage extends StatefulWidget {
  const DecisionPage({super.key});

  @override
  State<DecisionPage> createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  @override
  void initState() {
    super.initState();
    final accessToken = getIt<HiveService>().retrieveToken();

    if (accessToken == null) {
      _redirectToPage(
        context,
        RefresherRouter.signInRoute,
      );
      return;
    }

    final user = getIt<HiveService>().retrieveUser();

    if (user != null) {
      _redirectToPage(
        context,
        RefresherRouter.signInRoute,
      );
      return;
    } else {
      _redirectToPage(context, RefresherRouter.landingRoute);
      return;
    }
  }

  void _redirectToPage(
    BuildContext context,
    String routeName,
  ) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.router.pushNamed(routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
