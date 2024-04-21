import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_finder/models.dart';
import 'package:image_finder/ui/pages/home_page.dart';
import 'package:image_finder/ui/pages/image_view_page.dart';
import 'package:image_finder/utils/extensions.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: HomePage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: ImageViewPage.routeName,
            builder: (BuildContext context, GoRouterState state) {
              return ImageViewPage(
                image: state.extra as ImageItem,
              );
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      if (state.matchedLocation == ImageViewPage.routeName.path &&
          (state.extra is! ImageItem)) {
        return HomePage.routeName;
      }
      return null;
    },
  );
}
