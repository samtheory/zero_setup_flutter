import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';

import '../../data/models/navigation_models.dart';
import '../../data/repositories/navigation_repository.dart';
import 'navigation_state.dart';

/// Navigation state notifier for managing navigation state
class NavigationStateNotifier extends Notifier<NavigationState> {
  NavigationRepository get _repository => ref.read(navigationRepositoryProvider);

  @override
  NavigationState build() {
    talker.debug('NavigationStateNotifier: Building initial state');
    return NavigationState.initial();
  }

  /// Calculate route between two points
  Future<void> calculateRoute({
    required LatLng origin,
    required LatLng destination,
    String? originName,
    String? destinationName,
  }) async {
    talker.info('NavigationStateNotifier: Calculating route');

    state = state.copyWith(
      status: NavigationStatus.calculating,
      origin: origin,
      destination: destination,
      originName: originName,
      destinationName: destinationName,
      errorMessage: null,
    );

    try {
      final navigationData = await _repository.calculateRoute(
        origin: origin,
        destination: destination,
        originName: originName,
        destinationName: destinationName,
      );

      if (navigationData != null) {
        state = state.copyWith(
          navigationData: navigationData,
          status: NavigationStatus.ready,
          isPanelExpanded: true,
          lastUpdated: DateTime.now(),
        );
        talker.good('NavigationStateNotifier: Route calculated successfully');
      } else {
        state = state.copyWith(status: NavigationStatus.error, errorMessage: 'Failed to calculate route');
        talker.error('NavigationStateNotifier: Route calculation returned null');
      }
    } catch (e, st) {
      talker.error('NavigationStateNotifier: Error calculating route', e, st);
      state = state.copyWith(status: NavigationStatus.error, errorMessage: 'Error calculating route: $e');
    }
  }

  /// Start navigation mode
  void startNavigation() {
    if (!state.hasRoute) {
      talker.warning('NavigationStateNotifier: Cannot start navigation without route');
      return;
    }

    talker.info('NavigationStateNotifier: Starting navigation');
    state = state.copyWith(
      isNavigating: true,
      status: NavigationStatus.navigating,
      navigationData: state.navigationData?.copyWith(isNavigating: true, startTime: DateTime.now()),
    );
  }

  /// Stop navigation mode
  void stopNavigation() {
    talker.info('NavigationStateNotifier: Stopping navigation');
    state = state.copyWith(
      isNavigating: false,
      status: state.hasRoute ? NavigationStatus.ready : NavigationStatus.idle,
    );
  }

  /// Clear navigation data
  void clearNavigation() {
    talker.info('NavigationStateNotifier: Clearing navigation');
    state = NavigationState.initial();
  }

  /// Toggle navigation panel expanded/collapsed
  void togglePanel() {
    state = state.copyWith(isPanelExpanded: !state.isPanelExpanded);
  }

  /// Expand navigation panel
  void expandPanel() {
    state = state.copyWith(isPanelExpanded: true);
  }

  /// Collapse navigation panel
  void collapsePanel() {
    state = state.copyWith(isPanelExpanded: false);
  }

  /// Highlight a specific step
  void highlightStep(int index) {
    state = state.copyWith(highlightedStepIndex: index);
  }

  /// Update current step (during navigation)
  void updateCurrentStep(int stepIndex) {
    if (state.navigationData == null) return;

    state = state.copyWith(
      navigationData: state.navigationData!.copyWith(currentStepIndex: stepIndex),
      highlightedStepIndex: stepIndex,
    );
  }

  /// Update remaining distance and duration
  void updateProgress({required double remainingDistanceMeters, required double remainingDurationSeconds}) {
    if (state.navigationData == null) return;

    state = state.copyWith(
      navigationData: state.navigationData!.copyWith(
        remainingDistanceMeters: remainingDistanceMeters,
        remainingDurationSeconds: remainingDurationSeconds,
      ),
    );
  }

  /// Mark navigation as completed
  void completeNavigation() {
    talker.good('NavigationStateNotifier: Navigation completed!');
    state = state.copyWith(
      isNavigating: false,
      status: NavigationStatus.arrived,
      navigationData: state.navigationData?.copyWith(isCompleted: true, isNavigating: false),
    );
  }

  /// Navigate to destination from origin
  Future<void> navigateTo(LatLng destination, {String? destinationName}) async {
    // Use current location as origin if available
    // For now, we'll require explicit origin
    talker.warning('NavigationStateNotifier: navigateTo requires origin to be set');
  }

  /// Navigate from current POI to destination
  Future<void> navigateFromPoi({
    required LatLng origin,
    required LatLng destination,
    String? originName,
    String? destinationName,
  }) async {
    await calculateRoute(
      origin: origin,
      destination: destination,
      originName: originName,
      destinationName: destinationName,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Navigation State Provider
// ═══════════════════════════════════════════════════════════════════════════

final navigationNotifierProvider = NotifierProvider<NavigationStateNotifier, NavigationState>(
  NavigationStateNotifier.new,
);
