// display 2 routes
// LOGGED OUT ROUTE
// LOGGED IN ROUTE

import 'package:cartafri/screens/auth_screens/login_screen.dart';
import 'package:cartafri/screens/auth_screens/signup.dart';
import 'package:cartafri/screens/home.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {"/": (_) => const MaterialPage(child: SignUpPage())});
final loggedInRoute = RouteMap(
  routes: {
    "/": (_) => MaterialPage(
          child: AppHomePage(),
        ),
    // "/product:id":(_)=>MaterialPage(child: ProductDetail(product: product, tag: tag))
  },
);
