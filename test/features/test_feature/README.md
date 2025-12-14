# Test Feature - Unit Tests

This folder contains comprehensive unit and widget tests for the `test_feature` module.

## Test Structure

```
test/features/test_feature/
├── data/
│   ├── models/
│   │   └── item_model_test.dart          # Freezed model tests
│   └── repositories/
│       └── item_repository_impl_test.dart # Repository implementation tests
├── presentation/
│   ├── providers/
│   │   ├── item_state_test.dart          # State classes tests
│   │   └── item_provider_test.dart       # StateNotifier tests
│   ├── screens/
│   │   ├── item_list_screen_test.dart    # List screen widget tests
│   │   ├── item_detail_screen_test.dart  # Detail screen widget tests
│   │   └── item_form_screen_test.dart    # Form screen & validation tests
│   └── widgets/
│       └── item_card_test.dart           # ItemCard widget tests
└── README.md
```

## Running Tests

### Run all test_feature tests:
```bash
flutter test test/features/test_feature/
```

### Run specific test file:
```bash
flutter test test/features/test_feature/data/models/item_model_test.dart
```

### Run with coverage:
```bash
flutter test --coverage test/features/test_feature/
```

### Run with verbose output:
```bash
flutter test --reporter expanded test/features/test_feature/
```

## Test Categories

### 1. Model Tests (`item_model_test.dart`)
- Instance creation with required/optional fields
- `copyWith` functionality
- `fake()` factory for testing
- JSON serialization/deserialization
- Equality comparison

### 2. Repository Tests (`item_repository_impl_test.dart`)
- CRUD operations (getItems, getItem, createItem, updateItem, deleteItem)
- Pagination parameters passing
- Exception handling and rethrowing
- Mock API service integration

### 3. State Tests (`item_state_test.dart`)
- ItemListState initial values
- ItemListState computed properties (isEmpty, hasMore)
- ItemDetailState initial values
- State copyWith operations
- Boolean flag states (isLoading, hasError, etc.)

### 4. Provider Tests (`item_provider_test.dart`)
- Initial state verification
- Loading state management
- Successful data loading
- Error handling
- CRUD operations via notifier
- Provider container overrides

### 5. Widget Tests
#### ItemCard (`item_card_test.dart`)
- Title/description rendering
- Completion status icons
- Line-through decoration for completed items
- onTap/onEdit/onDelete callbacks
- Conditional button rendering
- Date formatting

#### ItemListScreen (`item_list_screen_test.dart`)
- Loading shimmer display
- Items rendering
- Error state with retry
- Empty state display
- Search field presence
- FAB for adding items
- App bar elements

#### ItemDetailScreen (`item_detail_screen_test.dart`)
- Loading indicator
- Item details display
- Error state with retry
- Not found state
- Edit/delete buttons
- Completion status display

#### ItemFormScreen (`item_form_screen_test.dart`)
- Create vs Edit mode title
- Form fields presence
- Input field interaction
- Form population in edit mode
- Acanthis validation tests
  - Empty field validation
  - Minimum length validation
- Completion checkbox toggle

## Testing Patterns Used

### 1. Provider Overrides
```dart
ProviderScope(
  overrides: [
    itemListProvider.overrideWith((ref) => testNotifier),
  ],
  child: MaterialApp(home: const ItemListScreen()),
)
```

### 2. Mock StateNotifier
```dart
class TestItemListNotifier extends StateNotifier<ItemListState>
    implements ItemListNotifier {
  TestItemListNotifier(super.state);
  
  @override
  Future<void> loadItems({bool refresh = false}) async {}
  // ... other method stubs
}
```

### 3. Repository Mocking with Mocktail
```dart
class MockItemRepository extends Mock implements ItemRepository {}

when(() => mockRepository.getItems(
  page: any(named: 'page'),
)).thenAnswer((_) async => items);
```

### 4. Widget Testing Pattern
```dart
testWidgets('renders item title', (tester) async {
  await tester.pumpWidget(createTestWidget());
  await tester.pumpAndSettle();
  
  expect(find.text('Test Item'), findsOneWidget);
});
```

## Before Running Tests

Ensure generated files are up to date:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Dependencies

- `flutter_test`: Flutter testing framework
- `mocktail`: Mock/stub library for Dart
- `hooks_riverpod`: For ProviderScope in widget tests
