// display 2 routes
// LOGGED OUT ROUTE
// LOGGED IN ROUTE

import 'package:cartafri/features/auth/screens/login_screen.dart';
import 'package:cartafri/features/auth/screens/signup.dart';
import 'package:cartafri/screens/cart.dart';
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
    '/product/:id': (route) => MaterialPage(
          child: ProductDetail(id: route.pathParameters['id']!),
        ),
    '/cart': (route) => const MaterialPage(
          child: CartPage(),
        )
    // "/product:id":(_)=>MaterialPage(child: ProductDetail(product: product, tag: tag))
  },
);
