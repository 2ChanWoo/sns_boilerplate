
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/creation/creation_screen.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/feed/feed_screen.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/memory/memory_screen.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/profile/profile_screen.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/sign/signin_screen.dart';
import 'package:sns_for_portfolio/presentation/ui/screen/today/today_screen.dart';
import 'package:collection/collection.dart';

import '../../presentation/ui/component/page_not_found_screen.dart';
import '../../presentation/ui/screen/bottom_navigation_layout.dart';
import '../util/dev_log.dart';

part 'router.g.dart';

/// dart run build_runner build --build-filter="lib/app/router/**"

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  routes: $appRoutes,
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    Log.i("GoRouter redirect: ${state.uri}");
    Log.i("GoRouter redirect-pathParameters: ${state.pathParameters}");
    Log.i("GoRouter redirect-extra: ${state.extra.toString()}");
  },
  errorBuilder: (context, state) {
    Log.i("Page Not Found:: ${state.error}");
    Log.e(state.error, StackTrace.current);
    return const PageNotFoundScreen();
  }
);

@TypedStatefulShellRoute<MainShellRouteData>(
 branches: [
   TypedStatefulShellBranch<FeedBranchData>(
     routes: [
       TypedGoRoute<FeedRouteData>(path: '/feed', name: 'feed')
     ]
   ),
   TypedStatefulShellBranch<TodayBranchData>(
       routes: [
         TypedGoRoute<TodayRouteData>(path: '/today', name: 'today')
       ]
   ),
   TypedStatefulShellBranch<CreationBranchData>(
       routes: [
         TypedGoRoute<CreationRouteData>(path: '/creation', name: 'creation')
       ]
   ),
   TypedStatefulShellBranch<MemoryBranchData>(
       routes: [
         TypedGoRoute<MemoryRouteData>(path: '/memory', name: 'memory')
       ]
   ),
   TypedStatefulShellBranch<ProfileBranchData>(
       routes: [
         TypedGoRoute<ProfileRouteData>(path: '/profile', name: 'profile')
       ]
   ),
 ]
)
class MainShellRouteData extends StatefulShellRouteData {

  // static const String $restorationScopeId = 'restorationScopeId';
  static final $parentNavigatorKey = rootNavigatorKey;

  const MainShellRouteData();

  @override
  Widget builder(
      BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return BottomNavigationLayout(navigationShell: navigationShell);
  }

  static Widget $navigatorContainerBuilder(BuildContext context,
      StatefulNavigationShell navigationShell, List<Widget> children) {
// return BottomNavigationLayout(navigationShell: navigationShell);

    //TODO: ShellRoute를 indexedStack 으로 만들지 않으면,, go로 이동이 되질 않는다..
    // (generator 를 쓰지 않고 [StatefulShellRoute.indexedStack] 로 써도 동일함.)
    // 따라서 아래와 같이 [StatefulShellRoute.indexedStack()] 구현해서 context.go 로도 이동이 가능해짐.
    final currentIndex = navigationShell.currentIndex;
    final List<Widget> stackItems = children
        .mapIndexed((int index, Widget child) =>
        _buildRouteBranchContainer(context, currentIndex == index, child))
        .toList();

    return IndexedStack(index: currentIndex, children: stackItems);
  }

  static Widget _buildRouteBranchContainer(
      BuildContext context, bool isActive, Widget child) {
    return Offstage(
      offstage: !isActive,
      child: TickerMode(
        enabled: isActive,
        child: child,
      ),
    );  }
}

class FeedBranchData extends StatefulShellBranchData {}
class TodayBranchData extends StatefulShellBranchData {}
class CreationBranchData extends StatefulShellBranchData {}
class MemoryBranchData extends StatefulShellBranchData {}
class ProfileBranchData extends StatefulShellBranchData {}

class FeedRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FeedScreen();
  }
}
class TodayRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodayScreen();
  }
}
class CreationRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreationScreen();
  }
}
class MemoryRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MemoryScreen();
  }
}
class ProfileRouteData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfileScreen();
  }
}

@TypedGoRoute<SignInRoute>(path: '/', name: 'signIn')
class SignInRoute extends GoRouteData {
  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignInScreen(
      authRepository: context.read(),
      onSignInSuccess: () {},
    );
  }
}
