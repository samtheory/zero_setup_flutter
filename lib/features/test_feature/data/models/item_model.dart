import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

/// Item model for the test feature
/// Demonstrates Freezed data class with JSON serialization
@freezed
sealed class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  /// Create a fake item for testing
  static ItemModel fake({int? id, String? title}) => ItemModel(
        id: id ?? 1,
        title: title ?? 'Test Item',
        description: 'This is a test item description',
        isCompleted: false,
        createdAt: DateTime.now(),
      );
}

/// Request model for creating/updating items
@freezed
sealed class ItemRequest with _$ItemRequest {
  const factory ItemRequest({
    required String title,
    required String description,
    @Default(false) bool isCompleted,
  }) = _ItemRequest;

  factory ItemRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestFromJson(json);
}
