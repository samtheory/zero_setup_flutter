import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zero_setup_flutter/features/map_feature/data/models/map_models.dart';

/// Vehicles Layer Widget
/// Displays vehicle markers with proper heading/rotation
/// Vehicles point in their direction of movement
class VehiclesLayer extends StatelessWidget {
  final List<VehicleModel> vehicles;
  final VehicleModel? selectedVehicle;
  final void Function(VehicleModel vehicle)? onVehicleTap;
  final bool showLabels;

  const VehiclesLayer({
    super.key,
    required this.vehicles,
    this.selectedVehicle,
    this.onVehicleTap,
    this.showLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: vehicles.map((vehicle) {
        final isSelected = selectedVehicle?.id == vehicle.id;
        return Marker(
          point: vehicle.latLng,
          width: isSelected ? 80 : 60,
          height: isSelected ? 90 : 70,
          child: GestureDetector(
            onTap: () => onVehicleTap?.call(vehicle),
            child: VehicleMarker(vehicle: vehicle, isSelected: isSelected, showLabel: showLabels || isSelected),
          ),
        );
      }).toList(),
    );
  }
}

/// Individual Vehicle marker widget
/// Rotates to show the direction the vehicle is heading
class VehicleMarker extends StatelessWidget {
  final VehicleModel vehicle;
  final bool isSelected;
  final bool showLabel;

  const VehicleMarker({super.key, required this.vehicle, this.isSelected = false, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (showLabel)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(vehicle.status),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 2)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vehicle.name,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (vehicle.isMoving) ...[
                  const SizedBox(width: 4),
                  Text(
                    '${vehicle.speed.toStringAsFixed(0)} km/h',
                    style: const TextStyle(fontSize: 9, color: Colors.white70),
                  ),
                ],
              ],
            ),
          ),
        const SizedBox(height: 4),
        // Vehicle icon with rotation
        Transform.rotate(
          // Rotate based on heading (0° = North)
          // We subtract PI/2 because the arrow icon points right by default (East)
          angle: vehicle.headingRadians - (math.pi / 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSelected ? 48 : 40,
            height: isSelected ? 48 : 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getStatusColor(vehicle.status),
              border: Border.all(color: Colors.white, width: isSelected ? 3 : 2),
              boxShadow: [
                BoxShadow(
                  color: _getStatusColor(vehicle.status).withValues(alpha: 0.4),
                  blurRadius: isSelected ? 12 : 6,
                  spreadRadius: isSelected ? 2 : 0,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Direction indicator (arrow)
                _buildDirectionArrow(),
                // Status indicator
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: vehicle.isMoving ? Colors.greenAccent : Colors.grey,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionArrow() {
    return CustomPaint(
      size: const Size(30, 30),
      painter: _VehicleArrowPainter(color: Colors.white, isMoving: vehicle.isMoving),
    );
  }

  Color _getStatusColor(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.available:
        return Colors.green;
      case VehicleStatus.busy:
        return Colors.blue;
      case VehicleStatus.offline:
        return Colors.grey;
      case VehicleStatus.maintenance:
        return Colors.orange;
    }
  }
}

/// Custom painter for vehicle arrow icon
/// Points in the direction of movement
class _VehicleArrowPainter extends CustomPainter {
  final Color color;
  final bool isMoving;

  _VehicleArrowPainter({required this.color, this.isMoving = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw a car-like shape pointing right (will be rotated by Transform)
    final path = Path();

    // Car body (pointing right)
    path.moveTo(centerX + size.width * 0.35, centerY); // Front point
    path.lineTo(centerX - size.width * 0.2, centerY - size.height * 0.25); // Top left
    path.lineTo(centerX - size.width * 0.25, centerY); // Back indent
    path.lineTo(centerX - size.width * 0.2, centerY + size.height * 0.25); // Bottom left
    path.close();

    canvas.drawPath(path, paint);

    // Add a small circle at front when moving (headlight effect)
    if (isMoving) {
      final headlightPaint = Paint()
        ..color = Colors.yellow.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX + size.width * 0.2, centerY), 3, headlightPaint);
    }
  }

  @override
  bool shouldRepaint(_VehicleArrowPainter oldDelegate) =>
      color != oldDelegate.color || isMoving != oldDelegate.isMoving;
}

/// Animated vehicle marker for smoother position updates
class AnimatedVehicleMarker extends StatefulWidget {
  final VehicleModel vehicle;
  final bool isSelected;
  final bool showLabel;

  const AnimatedVehicleMarker({super.key, required this.vehicle, this.isSelected = false, this.showLabel = false});

  @override
  State<AnimatedVehicleMarker> createState() => _AnimatedVehicleMarkerState();
}

class _AnimatedVehicleMarkerState extends State<AnimatedVehicleMarker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    // Pulse animation for moving vehicles
    if (widget.vehicle.isMoving) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedVehicleMarker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.vehicle.isMoving && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.vehicle.isMoving && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.vehicle.isMoving ? 1.0 + (_controller.value * 0.1) : 1.0,
          child: VehicleMarker(vehicle: widget.vehicle, isSelected: widget.isSelected, showLabel: widget.showLabel),
        );
      },
    );
  }
}

/// Vehicle Info Card - shown when a vehicle is selected
class VehicleInfoCard extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback? onClose;
  final VoidCallback? onTrack;
  final VoidCallback? onShowRoute;

  const VehicleInfoCard({super.key, required this.vehicle, this.onClose, this.onTrack, this.onShowRoute});

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
                    color: _getStatusColor(vehicle.status).withValues(alpha: 0.1),
                  ),
                  child: Icon(_getVehicleIcon(vehicle.vehicleType), color: _getStatusColor(vehicle.status), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          _StatusBadge(status: vehicle.status),
                          const SizedBox(width: 8),
                          if (vehicle.plateNumber != null)
                            Text(
                              vehicle.plateNumber!,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: onClose),
              ],
            ),
            const Divider(height: 24),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _VehicleStatItem(icon: Icons.speed, value: '${vehicle.speed.toStringAsFixed(0)} km/h', label: 'Speed'),
                _VehicleStatItem(icon: Icons.explore, value: _getHeadingDirection(vehicle.heading), label: 'Heading'),
                _VehicleStatItem(
                  icon: Icons.access_time,
                  value: vehicle.lastUpdated != null ? _formatTime(vehicle.lastUpdated!) : 'N/A',
                  label: 'Updated',
                ),
              ],
            ),
            // Driver info
            if (vehicle.driverName != null) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text('Driver: ${vehicle.driverName}', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
            const SizedBox(height: 16),
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onShowRoute,
                    icon: const Icon(Icons.route),
                    label: const Text('Show Route'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onTrack,
                    icon: const Icon(Icons.gps_fixed),
                    label: const Text('Track'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getStatusColor(vehicle.status),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.available:
        return Colors.green;
      case VehicleStatus.busy:
        return Colors.blue;
      case VehicleStatus.offline:
        return Colors.grey;
      case VehicleStatus.maintenance:
        return Colors.orange;
    }
  }

  IconData _getVehicleIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'sedan':
        return Icons.directions_car;
      case 'van':
        return Icons.airport_shuttle;
      case 'truck':
        return Icons.local_shipping;
      case 'motorcycle':
        return Icons.two_wheeler;
      default:
        return Icons.directions_car;
    }
  }

  String _getHeadingDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) return 'N';
    if (heading >= 22.5 && heading < 67.5) return 'NE';
    if (heading >= 67.5 && heading < 112.5) return 'E';
    if (heading >= 112.5 && heading < 157.5) return 'SE';
    if (heading >= 157.5 && heading < 202.5) return 'S';
    if (heading >= 202.5 && heading < 247.5) return 'SW';
    if (heading >= 247.5 && heading < 292.5) return 'W';
    return 'NW';
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}

class _StatusBadge extends StatelessWidget {
  final VehicleStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(status)),
      ),
      child: Text(
        status.value.toUpperCase(),
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _getStatusColor(status)),
      ),
    );
  }

  Color _getStatusColor(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.available:
        return Colors.green;
      case VehicleStatus.busy:
        return Colors.blue;
      case VehicleStatus.offline:
        return Colors.grey;
      case VehicleStatus.maintenance:
        return Colors.orange;
    }
  }
}

class _VehicleStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _VehicleStatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey)),
      ],
    );
  }
}

/// Vehicle List for selection
class VehicleListTile extends StatelessWidget {
  final VehicleModel vehicle;
  final bool isSelected;
  final VoidCallback? onTap;

  const VehicleListTile({super.key, required this.vehicle, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getStatusColor(vehicle.status).withValues(alpha: 0.2),
          border: Border.all(color: _getStatusColor(vehicle.status), width: 2),
        ),
        child: Icon(Icons.directions_car, color: _getStatusColor(vehicle.status), size: 20),
      ),
      title: Text(vehicle.name, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Row(
        children: [
          _StatusBadge(status: vehicle.status),
          const SizedBox(width: 8),
          if (vehicle.driverName != null) Text(vehicle.driverName!),
        ],
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: _getStatusColor(vehicle.status))
          : Text(
              vehicle.isMoving ? '${vehicle.speed.toStringAsFixed(0)} km/h' : 'Stopped',
              style: TextStyle(color: vehicle.isMoving ? Colors.green : Colors.grey, fontSize: 12),
            ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  Color _getStatusColor(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.available:
        return Colors.green;
      case VehicleStatus.busy:
        return Colors.blue;
      case VehicleStatus.offline:
        return Colors.grey;
      case VehicleStatus.maintenance:
        return Colors.orange;
    }
  }
}
