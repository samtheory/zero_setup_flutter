import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/navigation_models.dart';

part 'navigation_state.freezed.dart';

/// Navigation state for the map feature
@freezed
sealed class NavigationState with _$NavigationState {
  const NavigationState._();

  const factory NavigationState({
    /// Current navigation data (route, steps, etc.)
    NavigationData? navigationData,

    /// Current navigation status
    @Default(NavigationStatus.idle) NavigationStatus status,

    /// Origin point for navigation
    LatLng? origin,

    /// Destination point for navigation
    LatLng? destination,

    /// Origin name/address
    String? originName,

    /// Destination name/address
    String? destinationName,

    /// Whether navigation panel is expanded
    @Default(false) bool isPanelExpanded,

    /// Whether navigation mode is active
    @Default(false) bool isNavigating,

    /// Current step being highlighted in the list
    @Default(0) int highlightedStepIndex,

    /// Error message if any
    String? errorMessage,

    /// Last calculated route timestamp
    DateTime? lastUpdated,
  }) = _NavigationState;

  /// Initial/default state
  factory NavigationState.initial() => const NavigationState();

  /// Whether a route is available
  bool get hasRoute => navigationData != null;

  /// Whether navigation is ready to start
  bool get isReady => status == NavigationStatus.ready && hasRoute;

  /// Whether an error occurred
  bool get hasError => errorMessage != null;

  /// Get all navigation steps
  List<NavigationStep> get steps => navigationData?.steps ?? [];

  /// Get route points for polyline
  List<LatLng> get routePoints => navigationData?.routePoints ?? [];

  /// Formatted total distance
  String get formattedDistance => navigationData?.formattedDistance ?? '--';

  /// Formatted total duration
  String get formattedDuration => navigationData?.formattedDuration ?? '--';

  /// Formatted ETA
  String get formattedEta => navigationData?.formattedEta ?? '--:--';

  /// Current step
  NavigationStep? get currentStep => navigationData?.currentStep;

  /// Next step
  NavigationStep? get nextStep => navigationData?.nextStep;
}
