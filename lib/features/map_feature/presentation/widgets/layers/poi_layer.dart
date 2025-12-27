import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zero_setup_flutter/features/map_feature/data/models/map_models.dart';

/// POI (Point of Interest) Layer Widget
/// Displays POI markers with category-based icons and selection support
class PoiLayer extends StatelessWidget {
  final List<PoiModel> pois;
  final PoiModel? selectedPoi;
  final void Function(PoiModel poi)? onPoiTap;
  final bool showLabels;

  const PoiLayer({super.key, required this.pois, this.selectedPoi, this.onPoiTap, this.showLabels = false});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: pois.map((poi) {
        final isSelected = selectedPoi?.id == poi.id;
        return Marker(
          point: poi.latLng,
          width: isSelected ? 60 : 50,
          height: isSelected ? 73 : 60,
          child: GestureDetector(
            onTap: () => onPoiTap?.call(poi),
            child: _PoiMarker(poi: poi, isSelected: isSelected, showLabel: showLabels || isSelected),
          ),
        );
      }).toList(),
    );
  }
}

/// Individual POI marker widget
class _PoiMarker extends StatelessWidget {
  final PoiModel poi;
  final bool isSelected;
  final bool showLabel;

  const _PoiMarker({required this.poi, this.isSelected = false, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(poi.category);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (showLabel)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 2)],
            ),
            child: Text(
              poi.name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        const SizedBox(height: 2),
        // Marker
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 44 : 36,
          height: isSelected ? 44 : 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: isSelected ? Colors.white : Colors.white70, width: isSelected ? 3 : 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: isSelected ? 8 : 4,
                spreadRadius: isSelected ? 2 : 0,
              ),
            ],
          ),
          child: Center(
            child: Text(poi.category.emoji, style: TextStyle(fontSize: isSelected ? 20 : 16)),
          ),
        ),
        // Pin point
        CustomPaint(
          size: const Size(10, 8),
          painter: _PinPointPainter(color: color),
        ),
      ],
    );
  }

  Color _getCategoryColor(PoiCategory category) {
    switch (category) {
      case PoiCategory.restaurant:
        return Colors.orange;
      case PoiCategory.hotel:
        return Colors.purple;
      case PoiCategory.hospital:
        return Colors.red;
      case PoiCategory.gasStation:
        return Colors.amber;
      case PoiCategory.parking:
        return Colors.blue;
      case PoiCategory.atm:
        return Colors.green;
      case PoiCategory.pharmacy:
        return Colors.teal;
      case PoiCategory.shopping:
        return Colors.pink;
      case PoiCategory.attraction:
        return Colors.indigo;
      case PoiCategory.other:
        return Colors.grey;
    }
  }
}

/// Painter for the pin point below marker
class _PinPointPainter extends CustomPainter {
  final Color color;

  _PinPointPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PinPointPainter oldDelegate) => color != oldDelegate.color;
}

/// POI Info Card - shown when a POI is selected
class PoiInfoCard extends StatelessWidget {
  final PoiModel poi;
  final VoidCallback? onClose;
  final VoidCallback? onNavigate;

  const PoiInfoCard({super.key, required this.poi, this.onClose, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getCategoryColor(poi.category).withValues(alpha: 0.1),
                  ),
                  child: Center(child: Text(poi.category.emoji, style: const TextStyle(fontSize: 24))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        poi.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        poi.category.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: _getCategoryColor(poi.category)),
                      ),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: onClose),
              ],
            ),
            const Divider(height: 24),
            // Description
            if (poi.description != null) ...[
              Text(poi.description!, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
            ],
            // Address
            if (poi.address != null)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      poi.address!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            // Phone
            if (poi.phoneNumber != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    poi.phoneNumber!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onNavigate,
                  icon: const Icon(Icons.directions),
                  label: const Text('Navigate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(PoiCategory category) {
    switch (category) {
      case PoiCategory.restaurant:
        return Colors.orange;
      case PoiCategory.hotel:
        return Colors.purple;
      case PoiCategory.hospital:
        return Colors.red;
      case PoiCategory.gasStation:
        return Colors.amber;
      case PoiCategory.parking:
        return Colors.blue;
      case PoiCategory.atm:
        return Colors.green;
      case PoiCategory.pharmacy:
        return Colors.teal;
      case PoiCategory.shopping:
        return Colors.pink;
      case PoiCategory.attraction:
        return Colors.indigo;
      case PoiCategory.other:
        return Colors.grey;
    }
  }
}

/// POI Category Filter Chips
class PoiCategoryFilter extends StatelessWidget {
  final Set<PoiCategory>? selectedCategories;
  final void Function(Set<PoiCategory>?) onFilterChanged;

  const PoiCategoryFilter({super.key, required this.selectedCategories, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          // All button
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('All'),
              selected: selectedCategories == null || selectedCategories!.isEmpty,
              onSelected: (_) => onFilterChanged(null),
            ),
          ),
          // Category chips
          ...PoiCategory.values.map((category) {
            final isSelected = selectedCategories?.contains(category) ?? false;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                avatar: Text(category.emoji),
                label: Text(category.name),
                selected: isSelected,
                onSelected: (selected) {
                  final newSet = Set<PoiCategory>.from(selectedCategories ?? {});
                  if (selected) {
                    newSet.add(category);
                  } else {
                    newSet.remove(category);
                  }
                  onFilterChanged(newSet.isEmpty ? null : newSet);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
