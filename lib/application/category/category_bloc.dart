import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/failure.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/use_cases/get_items_by_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetItemsByCategory getItemsByCategory;

  CategoryBloc({required this.getItemsByCategory}) : super(const CategoryState()) {
    on<CategoryItemsRequested>(_onCategoryItemsRequested);
    on<CategoryRetry>(_onCategoryRetry);
  }

  Future<void> _onCategoryItemsRequested(
    CategoryItemsRequested event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    
    final result = await getItemsByCategory(event.category);
    
    switch (result) {
      case Success<List<MenuItem>>():
        emit(state.copyWith(
          status: CategoryStatus.loaded,
          items: result.data,
          error: null,
        ));
      case Error<List<MenuItem>>():
        emit(state.copyWith(
          status: CategoryStatus.failure,
          error: result.failure,
        ));
    }
  }

  Future<void> _onCategoryRetry(
    CategoryRetry event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(status: CategoryStatus.initial));
  }
}
