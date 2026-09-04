import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forest_brewery_test/core/di/service_locator.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_boc.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_event.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_state.dart';
import 'package:forest_brewery_test/features/breweries/presentation/widget/brewery_tile.dart';
import 'package:go_router/go_router.dart';

class BreweryListPage extends StatefulWidget {
  const BreweryListPage({super.key});

  @override
  State<BreweryListPage> createState() => _BreweryListPageState();
}

class _BreweryListPageState extends State<BreweryListPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<BreweryListBloc>().add(const BreweryListFetch());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<BreweryListBloc>().add(const BreweryListLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BreweryListBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Breweries'), elevation: 0),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<BreweryListBloc>().add(const BreweryListRefresh());
          },
          child: BlocBuilder<BreweryListBloc, BreweryListState>(
            builder: (context, state) {
              if (state is BreweryListInitial) {
                return const SizedBox.shrink();
              }

              if (state is BreweryListLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is BreweryListError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is BreweryListEmpty) {
                return const Center(child: Text('No breweries found'));
              }

              if (state is BreweryListSuccess) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.breweries.length,
                  itemBuilder: (context, index) {
                    final brewery = state.breweries[index];
                    return BreweryTile(
                      brewery: brewery,
                      onTap: () {
                        context.pushNamed(
                          'breweryDetail',
                          pathParameters: {'id': brewery.id},
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
