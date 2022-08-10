import 'package:flutter/cupertino.dart';
import 'package:flutter_hello_world/pages/detail_page.dart';
import 'package:flutter_hello_world/pages/main_page.dart';
import 'package:flutter_hello_world/pages/welcome_page.dart';
import 'package:flutter_hello_world/services/model/trip.dart';
import 'package:collection/collection.dart';

enum Path {
  welcome('/welcome'),
  home('/home'),
  detail('/detail');

  const Path(this.value);
  final String value;
}

class AppNavigator {
  static GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == Path.welcome.value) {
      return CupertinoPageRoute(builder: (context) => WelcomePage());
    } else if (settings.name == Path.home.value) {
      dynamic args = settings.arguments;
      if (args is List<Object>) {
        dynamic selectedTabIndex = args.firstOrNull;
        if (selectedTabIndex is int) {
          return CupertinoPageRoute(
            builder: (context) => MainPage(selectedTabIndex: selectedTabIndex),
          );
        }
      }
    } else if (settings.name == Path.detail.value) {
      dynamic args = settings.arguments;
      if (args is List<Object>) {
        dynamic trip = args.firstOrNull;
        if (trip is TripModel) {
          return CupertinoPageRoute(
            builder: (context) => DetailPage(trip: trip),
          );
        }
      }
    }
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
    );
  }

  static Future? push<T>(Path route, [T? arguments]) =>
      _state?.pushNamed(route.value, arguments: arguments);

  static Future? replaceWith<T>(Path route, [T? arguments]) =>
      _state?.pushReplacementNamed(route.value, arguments: arguments);

  static void pop() => _state?.pop();

  static NavigatorState? get _state => _navigatorKey.currentState;
}
