import 'package:flutter/material.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:url_launcher/url_launcher.dart';

class BreweryInfoCard extends StatelessWidget {
  final Brewery brewery;

  const BreweryInfoCard({super.key, required this.brewery});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(brewery.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        if ((brewery.address1 ?? '').isNotEmpty)
          _InfoRow(label: 'Address', value: brewery.address1!),
        if ((brewery.address2 ?? '').isNotEmpty)
          _InfoRow(label: 'Address 2', value: brewery.address2!),
        if ((brewery.address3 ?? '').isNotEmpty)
          _InfoRow(label: 'Address 3', value: brewery.address3!),
        const SizedBox(height: 16),
        if (brewery.phone != null)
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(brewery.phone!),
            onTap: () => _launchPhone(brewery.phone!),
          ),
        if (brewery.websiteUrl != null)
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Visit Website'),
            onTap: () => _launchUrl(brewery.websiteUrl!),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
