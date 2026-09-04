import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_brewery_test/config/app_router.dart';
import 'package:forest_brewery_test/core/di/service_locator.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_boc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreweryListBloc>(
      create: (_) => getIt<BreweryListBloc>(),
      child: MaterialApp.router(
        title: 'Brewery App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        routerConfig: appRouter,
      ),
    );
  }
}
