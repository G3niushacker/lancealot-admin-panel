import 'package:flutter/material.dart';
import 'package:lancealot_admin_panel/routes/routes_names.dart';
import 'package:lancealot_admin_panel/views/customers/total_customers.dart';
import 'package:lancealot_admin_panel/views/guards/guard_profile.dart';
import 'package:lancealot_admin_panel/views/guards/total_guards.dart';
import 'package:lancealot_admin_panel/views/home_page.dart';
import 'package:lancealot_admin_panel/views/not_found_page.dart';
import 'package:lancealot_admin_panel/views/online_guards/guards_onmap.dart';
import 'package:lancealot_admin_panel/views/online_guards/online_guards.dart';
import 'package:lancealot_admin_panel/views/online_guards/see_profiles.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case totalGuards:
        return MaterialPageRoute(builder: (_) => TotalGuards());
      case totalCustomers:
        return MaterialPageRoute(builder: (_) => TotalCustomers());
      case dashboard:
        return MaterialPageRoute(builder: (_) => HomePage());
      case onlineGuards:
        return MaterialPageRoute(builder: (_) => OnlineGuards());
      case seeProfiles:
        return MaterialPageRoute(builder: (_) => SeeProfiles());
      case guardProfile:
        return MaterialPageRoute(builder: (_) => GuardProfile());
      case mapScreen:
        return MaterialPageRoute(builder: (_) => GuardsOnMap());
    }
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}
