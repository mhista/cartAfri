// display 2 routes
// LOGGED OUT ROUTE
// LOGGED IN ROUTE

import 'package:cartafri/features/auth/screens/signup.dart';
import 'package:cartafri/screens/AppScreen.dart';
import 'package:cartafri/screens/cart.dart';
import 'package:cartafri/screens/notifications.dart';
import 'package:cartafri/screens/payment.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:cartafri/screens/splashScreens/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    "/": (_) => const MaterialPage(child: SignUpPage()),
  },
);
final loggedInRoute = RouteMap(
  routes: {
    "/": (_) => const MaterialPage(
          child: HomePage(),
        ),
    '/product/:id': (route) => MaterialPage(
          child: ProductDetail(id: route.pathParameters['id']!),
        ),
    '/cart': (routeData) => const MaterialPage(
          child: CartPage(),
        ),
    '/checkout/payment': (checkout) => MaterialPage(
          child: PaymentScreen(
            amount: checkout.queryParameters['amount']!,
          ),
        ),
    '/account/notification': (routeData) =>
        const MaterialPage(child: NotificationPage())
  },
);

final splashRoute =
    RouteMap(routes: {"/": (_) => const MaterialPage(child: SplashScreen1())});
