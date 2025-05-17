import 'package:flutter/material.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../personality/PersonalityPage.dart';
import 'go_router_refresh_stream.dart';
import 'not_found_screen.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  signIn,
  home,
  profile,
  personality,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) async {
      return null;
    },
    // refresh 시점: 어떤 state가 변경될때 refresh 시도할 것인지?
    //refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/home/:room',
        name: AppRoute.home.name,
        pageBuilder: (context, state) => NoTransitionPage(
          child: MyHomePage(roomTag: state.pathParameters['room']),
        ),
      ),
      GoRoute(
        path: '/personality/:room/:senderKey',
        name: AppRoute.personality.name,
        pageBuilder: (context, state) {
          final roomTag = state.pathParameters['room']!;
          final senderKey = state.pathParameters['senderKey']!;
          return NoTransitionPage(
            child: PersonalityPage(roomTag: roomTag, senderKey: senderKey),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
