# Foodie Flow

A scoped Flutter demo that implements a single realistic food-ordering workflow with clean architecture and BLoC state management.

## Features

- **Browse restaurants** with loading and simulated network failures
- **View menu** for a restaurant
- **Add to cart** and adjust quantities
- **Checkout** and simulate **payment** (random success/failure)
- **Order confirmation** with ID or **error** with retry

## Architecture

- **Layers**
  - `lib/domain/` models (`Restaurant`, `MenuItem`, `Cart`, `Order`) and repository interfaces
  - `lib/data/` fake repositories (`FakeRestaurantRepository`, `FakeOrderRepository`)
  - `lib/domain/usecases/` use-cases (`GetRestaurants`, `GetMenu`, `PlaceOrder`)
  - `lib/application/` state management (BLoC/Cubit)
  - `lib/presentation/` UI pages and app setup
  - `lib/core/failure.dart` centralized `Failure` and `Result` (Either-like) wrapper
- **State management**: `flutter_bloc`
- **DI**: `get_it` (`lib/di/locator.dart`)
- **Material 3** theme, rounded cards, hero animation for restaurant image, animated checkout button

## Tech Stack / Dependencies

- flutter_bloc, equatable, get_it
- dev: bloc_test, mocktail

## Run

```bash
flutter pub get
flutter run
```

App entry: `lib/main.dart` bootstraps `MyApp` and registers dependencies in `setupLocator()`.

## Tests

Unit tests cover restaurant load success/failure, cart totals, and order success/failure (with retry):

```bash
flutter test
```

Test files:

- `test/restaurant_list_bloc_test.dart`
- `test/menu_cart_cubit_test.dart`
- `test/order_bloc_test.dart`

## Screenshots
<img src="docs/screenshots/main.jpeg" alt="Home Screen" width="300"/>

### Menu
<img src="docs/screenshots/detail.jpeg" alt="Menu Screen" width="300"/>

### Checkout
<img src="docs/screenshots/cartitem.jpeg" alt="Checkout Screen" width="300"/>

<img src="docs/screenshots/order.jpeg" alt="Checkout Screen" width="300"/>
Place screenshots here (optional): `docs/screenshots/`

## Notes

- All network interactions are simulated with delays and random failures.
- No login or backend. Focused single workflow.
- Designed to compile on stable Flutter; see `pubspec.yaml` for constraints.
