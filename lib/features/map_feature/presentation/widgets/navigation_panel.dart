import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/features/map_feature/map_feature.dart';

import '../providers/navigation_state.dart';

/// Google Maps-style navigation panel with turn-by-turn directions
class NavigationPanel extends StatelessWidget {
  const NavigationPanel({
    super.key,
    required this.navigationState,
    this.onClose,
    this.onStartNavigation,
    this.onStopNavigation,
    this.onStepTapped,
    this.onToggleExpand,
  });

  final NavigationState navigationState;
  final VoidCallback? onClose;
  final VoidCallback? onStartNavigation;
  final VoidCallback? onStopNavigation;
  final void Function(int stepIndex)? onStepTapped;
  final VoidCallback? onToggleExpand;

  @override
  Widget build(BuildContext context) {
    if (!navigationState.hasRoute) {
      return const SizedBox.shrink();
    }

    final isExpanded = navigationState.isPanelExpanded;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(maxHeight: isExpanded ? MediaQuery.of(context).size.height * 0.6 : 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          GestureDetector(
            onTap: onToggleExpand,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ),
          // Header with summary
          _NavigationHeader(
            navigationState: navigationState,
            onClose: onClose,
            onStartNavigation: onStartNavigation,
            onStopNavigation: onStopNavigation,
          ),
          // Expanded content - turn-by-turn list
          if (isExpanded)
            Expanded(
              child: _NavigationStepsList(
                steps: navigationState.steps,
                highlightedIndex: navigationState.highlightedStepIndex,
                onStepTapped: onStepTapped,
              ),
            ),
        ],
      ),
    );
  }
}

/// Navigation header with route summary
class _NavigationHeader extends StatelessWidget {
  const _NavigationHeader({required this.navigationState, this.onClose, this.onStartNavigation, this.onStopNavigation});

  final NavigationState navigationState;
  final VoidCallback? onClose;
  final VoidCallback? onStartNavigation;
  final VoidCallback? onStopNavigation;

  @override
  Widget build(BuildContext context) {
    final navigationData = navigationState.navigationData!;
    final isNavigating = navigationState.isNavigating;
    final currentStep = navigationState.currentStep;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current/Next maneuver (during navigation)
          if (isNavigating && currentStep != null) _CurrentManeuverCard(step: currentStep),

          // Route summary row
          Row(
            children: [
              // Duration and distance
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isNavigating ? navigationData.formattedRemainingDuration : navigationData.formattedDuration,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            isNavigating ? navigationData.formattedRemainingDistance : navigationData.formattedDistance,
                            style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'ETA ${navigationData.formattedEta}',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            navigationData.destinationName,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isNavigating)
                    FilledButton.icon(
                      onPressed: onStartNavigation,
                      icon: const Icon(Icons.navigation, size: 18),
                      label: const Text('Start'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    )
                  else
                    FilledButton.icon(
                      onPressed: onStopNavigation,
                      icon: const Icon(Icons.stop, size: 18),
                      label: const Text('Stop'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(backgroundColor: Colors.grey[200]),
                  ),
                ],
              ),
            ],
          ),
          // Progress bar (during navigation)
          if (isNavigating) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: navigationData.progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Current maneuver card shown during navigation
class _CurrentManeuverCard extends StatelessWidget {
  const _CurrentManeuverCard({required this.step});

  final NavigationStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
            child: Icon(step.icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.formattedDistance,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  step.instruction,
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Scrollable list of navigation steps
class _NavigationStepsList extends StatelessWidget {
  const _NavigationStepsList({required this.steps, required this.highlightedIndex, this.onStepTapped});

  final List<NavigationStep> steps;
  final int highlightedIndex;
  final void Function(int)? onStepTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: steps.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final step = steps[index];
        final isHighlighted = index == highlightedIndex;

        return _NavigationStepTile(step: step, isHighlighted: isHighlighted, onTap: () => onStepTapped?.call(index));
      },
    );
  }
}

/// Individual step tile in the navigation list
class _NavigationStepTile extends StatelessWidget {
  const _NavigationStepTile({required this.step, required this.isHighlighted, this.onTap});

  final NavigationStep step;
  final bool isHighlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isHighlighted ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              // Maneuver icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isHighlighted ? step.color : step.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(step.icon, color: isHighlighted ? Colors.white : step.color, size: 24),
              ),
              const SizedBox(width: 12),
              // Instruction text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.instruction,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                        color: isHighlighted ? Colors.blue[900] : Colors.black87,
                      ),
                    ),
                    if (step.streetName.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        step.streetName,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Distance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                child: Text(
                  step.formattedDistance,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact navigation banner shown at top during navigation
class NavigationBanner extends StatelessWidget {
  const NavigationBanner({super.key, required this.currentStep, this.nextStep, this.onTap});

  final NavigationStep currentStep;
  final NavigationStep? nextStep;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Current maneuver
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(currentStep.icon, color: Colors.white, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentStep.formattedDistance,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          currentStep.instruction,
                          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Next maneuver preview
            if (nextStep != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Text('Then', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7))),
                    const SizedBox(width: 8),
                    Icon(nextStep!.icon, color: Colors.white.withOpacity(0.9), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        nextStep!.streetName.isNotEmpty ? nextStep!.streetName : nextStep!.maneuverType.displayName,
                        style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      nextStep!.formattedDistance,
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
