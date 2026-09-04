class AppRoutes {
  static const String breweryList = '/';
  static const String breweryDetail = 'breweries/:id';

  static String breweryDetailRoute(String id) => '/breweries/$id';
}
