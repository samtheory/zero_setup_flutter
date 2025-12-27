import 'package:flutter/material.dart';

import '../../data/models/map_models.dart';

/// Map Template Selector Widget
/// Allows switching between different map tile providers/styles
class MapTemplateSelector extends StatelessWidget {
  final MapTemplate currentTemplate;
  final void Function(MapTemplate template) onTemplateChanged;

  const MapTemplateSelector({super.key, required this.currentTemplate, required this.onTemplateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: PopupMenuButton<MapTemplate>(
        initialValue: currentTemplate,
        onSelected: onTemplateChanged,
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        itemBuilder: (context) => MapTemplate.values.map((template) {
          final isSelected = template == currentTemplate;
          return PopupMenuItem<MapTemplate>(
            value: template,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _getTemplateColor(template)),
                  child: Icon(_getTemplateIcon(template), size: 14, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    template.displayName,
                    style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
                if (isSelected) const Icon(Icons.check, color: Colors.green, size: 18),
              ],
            ),
          );
        }).toList(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.layers, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(currentTemplate.displayName, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTemplateIcon(MapTemplate template) {
    switch (template) {
      case MapTemplate.openStreetMap:
        return Icons.map;
      case MapTemplate.openTopoMap:
        return Icons.terrain;
      case MapTemplate.cartoLight:
        return Icons.wb_sunny;
      case MapTemplate.cartoDark:
        return Icons.nights_stay;
      case MapTemplate.cartoVoyager:
        return Icons.explore;
      case MapTemplate.esriWorldStreetMap:
        return Icons.location_city;
      case MapTemplate.esriWorldImagery:
        return Icons.satellite;
      case MapTemplate.esriWorldImagery2:
        return Icons.sailing_sharp;
    }
  }

  Color _getTemplateColor(MapTemplate template) {
    switch (template) {
      case MapTemplate.openStreetMap:
        return Colors.green;
      case MapTemplate.openTopoMap:
        return Colors.brown;
      case MapTemplate.cartoLight:
        return Colors.amber;
      case MapTemplate.cartoDark:
        return Colors.indigo;
      case MapTemplate.cartoVoyager:
        return Colors.teal;
      case MapTemplate.esriWorldStreetMap:
        return Colors.blue;
      case MapTemplate.esriWorldImagery:
        return Colors.blueGrey;
      case MapTemplate.esriWorldImagery2:
        return Colors.pink;
    }
  }
}

/// Compact Template Selector (Grid style)
class MapTemplateGrid extends StatelessWidget {
  final MapTemplate currentTemplate;
  final void Function(MapTemplate template) onTemplateChanged;

  const MapTemplateGrid({super.key, required this.currentTemplate, required this.onTemplateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Map Style', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: MapTemplate.values.length,
            itemBuilder: (context, index) {
              final template = MapTemplate.values[index];
              final isSelected = template == currentTemplate;
              return _TemplateGridItem(
                template: template,
                isSelected: isSelected,
                onTap: () => onTemplateChanged(template),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TemplateGridItem extends StatelessWidget {
  final MapTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  const _TemplateGridItem({required this.template, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getTemplateIcon(template),
              size: 24,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              _getShortName(template),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTemplateIcon(MapTemplate template) {
    switch (template) {
      case MapTemplate.openStreetMap:
        return Icons.map;
      case MapTemplate.openTopoMap:
        return Icons.terrain;
      case MapTemplate.cartoLight:
        return Icons.wb_sunny;
      case MapTemplate.cartoDark:
        return Icons.nights_stay;
      case MapTemplate.cartoVoyager:
        return Icons.explore;
      case MapTemplate.esriWorldStreetMap:
        return Icons.location_city;
      case MapTemplate.esriWorldImagery:
        return Icons.satellite;
      case MapTemplate.esriWorldImagery2:
        return Icons.sailing_sharp;
    }
  }

  String _getShortName(MapTemplate template) {
    switch (template) {
      case MapTemplate.openStreetMap:
        return 'Standard';
      case MapTemplate.openTopoMap:
        return 'Topo';
      case MapTemplate.cartoLight:
        return 'Light';
      case MapTemplate.cartoDark:
        return 'Dark';
      case MapTemplate.cartoVoyager:
        return 'Voyager';
      case MapTemplate.esriWorldStreetMap:
        return 'Street';
      case MapTemplate.esriWorldImagery:
        return 'Satellite';
      case MapTemplate.esriWorldImagery2:
        return 'Stadia';
    }
  }
}
