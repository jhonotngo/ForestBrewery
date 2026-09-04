import 'package:forest_brewery_test/config/app_routes.dart';
import 'package:forest_brewery_test/features/breweries/presentation/pages/brewery_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.breweryList,
  routes: [
    GoRoute(
      path: AppRoutes.breweryList,
      name: 'breweryList',
      builder: (context, state) => const BreweryListPage(),
      routes: [],
    ),
  ],
);
