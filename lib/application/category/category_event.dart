part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryItemsRequested extends CategoryEvent {
  final String category;

  const CategoryItemsRequested(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryRetry extends CategoryEvent {
  const CategoryRetry();
}
