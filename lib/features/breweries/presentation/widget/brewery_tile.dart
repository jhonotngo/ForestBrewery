import 'package:flutter/material.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';

class BreweryTile extends StatelessWidget {
  final Brewery brewery;
  final VoidCallback onTap;

  const BreweryTile({super.key, required this.brewery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          brewery.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Brewery Type: ${brewery.breweryType ?? 'Unknown'} • City: ${brewery.city ?? 'N/A'}',
        ),
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
