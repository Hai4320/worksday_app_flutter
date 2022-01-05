import 'package:flutter/material.dart';
import 'package:worksday_app/screens/provider.dart';
import 'package:worksday_app/screens/start/start.dart';
class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => Start(),
      '/provider':(_) => Provider()
    };
  }
}
