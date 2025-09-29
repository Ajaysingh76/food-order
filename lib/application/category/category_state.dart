part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, failure }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<MenuItem> items;
  final Failure? error;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.items = const [],
    this.error,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<MenuItem>? items,
    Failure? error,
  }) {
    return CategoryState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, error];
}
