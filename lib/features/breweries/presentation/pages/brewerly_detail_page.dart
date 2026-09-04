import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_brewery_test/core/di/service_locator.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_brewery_detail_usecase.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_detail/brewery_detail_bloc.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_detail/brewery_detail_state.dart';
import 'package:forest_brewery_test/features/breweries/presentation/widget/brewery_info_card.dart';
import 'package:go_router/go_router.dart';

class BreweryDetailPage extends StatefulWidget {
  final String breweryId;

  const BreweryDetailPage({super.key, required this.breweryId});

  @override
  State<BreweryDetailPage> createState() => _BreweryDetailPageState();
}

class _BreweryDetailPageState extends State<BreweryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreweryDetailBloc>(
      create: (_) => BreweryDetailBloc(
        getBreweryDetailUseCase: getIt<GetBreweryDetailUseCase>(),
        breweryId: widget.breweryId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Brewery Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<BreweryDetailBloc, BreweryDetailState>(
          builder: (context, state) {
            if (state is BreweryDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BreweryDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            if (state is BreweryDetailSuccess) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: BreweryInfoCard(brewery: state.brewery),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
