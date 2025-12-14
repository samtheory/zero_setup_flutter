import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/item_model.dart';
import '../providers/item_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Form Validation
// ═══════════════════════════════════════════════════════════════════════════

/// Item form validation helpers
/// Demonstrates type-safe validation with custom error messages
class ItemFormSchema {
  /// Title validation constraints
  static const int titleMinLength = 3;
  static const int titleMaxLength = 100;

  /// Description validation constraints  
  static const int descriptionMinLength = 10;
  static const int descriptionMaxLength = 500;

  /// Validate title field
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'عنوان الزامی است';
    }
    final trimmed = value.trim();
    if (trimmed.length < titleMinLength) {
      return 'عنوان باید حداقل ۳ کاراکتر باشد';
    }
    if (trimmed.length > titleMaxLength) {
      return 'عنوان نباید بیش از ۱۰۰ کاراکتر باشد';
    }
    return null;
  }

  /// Validate description field
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'توضیحات الزامی است';
    }
    final trimmed = value.trim();
    if (trimmed.length < descriptionMinLength) {
      return 'توضیحات باید حداقل ۱۰ کاراکتر باشد';
    }
    if (trimmed.length > descriptionMaxLength) {
      return 'توضیحات نباید بیش از ۵۰۰ کاراکتر باشد';
    }
    return null;
  }

  /// Validate entire form
  static bool validate({
    required String title,
    required String description,
    required ValueNotifier<String?> titleError,
    required ValueNotifier<String?> descriptionError,
  }) {
    final titleResult = validateTitle(title);
    final descriptionResult = validateDescription(description);
    
    titleError.value = titleResult;
    descriptionError.value = descriptionResult;
    
    return titleResult == null && descriptionResult == null;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Item Form Screen
// ═══════════════════════════════════════════════════════════════════════════

/// Item Form Screen for Create/Edit
/// Demonstrates:
/// - Form validation with Acanthis
/// - Form state with Flutter Hooks
/// - Loading existing data for edit
/// - Success/error handling
/// - Navigation after save
class ItemFormScreen extends HookConsumerWidget {
  const ItemFormScreen({super.key, this.itemId});

  /// If itemId is provided, we're editing; otherwise creating
  final int? itemId;

  bool get isEditing => itemId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailProvider);
    final theme = Theme.of(context);

    // Form controllers
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final isCompletedState = useState(false);

    // Form key for Flutter's form validation
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Error states for real-time validation
    final titleError = useState<String?>(null);
    final descriptionError = useState<String?>(null);

    // Track if form was submitted
    final hasSubmitted = useState(false);

    // Load item for editing
    useEffect(() {
      if (isEditing) {
        talker.info('📝 Loading item for edit: $itemId');
        Future.microtask(() {
          ref.read(itemDetailProvider.notifier).loadItem(itemId!);
        });
      } else {
        talker.info('📝 Creating new item');
        // Clear any existing state for new item
        ref.read(itemDetailProvider.notifier).clear();
      }
      return null;
    }, [itemId]);

    // Populate form when item loads (edit mode)
    useEffect(() {
      if (isEditing && state.item != null) {
        talker.debug('📝 Populating form with item data');
        titleController.text = state.item!.title;
        descriptionController.text = state.item!.description;
        isCompletedState.value = state.item!.isCompleted;
      }
      return null;
    }, [state.item]);

    // Show success message
    useEffect(() {
      if (state.successMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
          ref.read(itemDetailProvider.notifier).clearSuccessMessage();
        });
      }
      return null;
    }, [state.successMessage]);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'ویرایش آیتم' : 'ایجاد آیتم جدید'),
      ),
      body: state.isLoading && isEditing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title field
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'عنوان *',
                        hintText: 'عنوان آیتم را وارد کنید',
                        errorText: titleError.value,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        // Clear error on change
                        titleError.value = null;
                        // Real-time validation if already submitted
                        if (hasSubmitted.value) {
                          titleError.value = ItemFormSchema.validateTitle(value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description field
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'توضیحات *',
                        hintText: 'توضیحات آیتم را وارد کنید',
                        errorText: descriptionError.value,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.description),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      onChanged: (value) {
                        descriptionError.value = null;
                        if (hasSubmitted.value) {
                          descriptionError.value = ItemFormSchema.validateDescription(value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Is completed checkbox
                    Card(
                      child: CheckboxListTile(
                        title: const Text('تکمیل شده'),
                        subtitle: const Text('این آیتم به اتمام رسیده است'),
                        value: isCompletedState.value,
                        onChanged: (value) {
                          talker.debug('📝 isCompleted changed: $value');
                          isCompletedState.value = value ?? false;
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        secondary: Icon(
                          isCompletedState.value ? Icons.check_circle : Icons.pending,
                          color: isCompletedState.value ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Error message from API
                    if (state.error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error, color: Colors.red.shade700),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                state.error!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                ref.read(itemDetailProvider.notifier).clearError();
                              },
                            ),
                          ],
                        ),
                      ),

                    // Character count indicators
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'عنوان: ${titleController.text.length}/100',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: titleController.text.length > 100
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'توضیحات: ${descriptionController.text.length}/500',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: descriptionController.text.length > 500
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state.isSaving
                            ? null
                            : () => _handleSubmit(
                                  context,
                                  ref,
                                  titleController.text,
                                  descriptionController.text,
                                  isCompletedState.value,
                                  titleError,
                                  descriptionError,
                                  hasSubmitted,
                                ),
                        child: state.isSaving
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(isEditing ? Icons.save : Icons.add),
                                  const SizedBox(width: 8),
                                  Text(isEditing ? 'ذخیره تغییرات' : 'ایجاد آیتم'),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Cancel button
                    OutlinedButton(
                      onPressed: () {
                        talker.info('📝 Form cancelled');
                        context.pop();
                      },
                      child: const Text('انصراف'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    String title,
    String description,
    bool isCompleted,
    ValueNotifier<String?> titleError,
    ValueNotifier<String?> descriptionError,
    ValueNotifier<bool> hasSubmitted,
  ) async {
    hasSubmitted.value = true;
    talker.info('📝 Form submitted');

    // Validate form
    final isValid = ItemFormSchema.validate(
      title: title.trim(),
      description: description.trim(),
      titleError: titleError,
      descriptionError: descriptionError,
    );

    if (!isValid) {
      talker.warning('📝 Form validation failed');
      return;
    }

    talker.info('📝 Form validation passed');

    // Create request
    final request = ItemRequest(
      title: title.trim(),
      description: description.trim(),
      isCompleted: isCompleted,
    );

    final notifier = ref.read(itemDetailProvider.notifier);
    ItemModel? result;

    if (isEditing) {
      talker.info('📝 Updating item: $itemId');
      result = await notifier.updateItem(itemId!, request);
    } else {
      talker.info('📝 Creating new item');
      result = await notifier.createItem(request);
    }

    if (result != null && context.mounted) {
      talker.info('📝 Form submission successful');
      context.pop(); // Navigate back
    }
  }

}
