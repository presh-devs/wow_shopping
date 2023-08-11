part of 'categories_page_cubit.dart';

final class CategoriesPageState {
  final CategoryItem selectedCategory;

  CategoriesPageState({this.selectedCategory = CategoryItem.global});

  CategoriesPageState copyWith({ 
    final CategoryItem? selectedCategory,
  }) {
    return CategoriesPageState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
