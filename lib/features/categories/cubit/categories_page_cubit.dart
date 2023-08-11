import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/models/category_item.dart';

part 'categories_page_state.dart';

class CategoriesPageCubit extends Cubit<CategoriesPageState> {
  CategoriesPageCubit() : super(CategoriesPageState());


   void onCategoryItemPressed(CategoryItem value) {
    // FIXME: implement filter or deep link?
   // emit(state.copyWith( selectedCategory: value,));
    emit(state.copyWith(selectedCategory: value));
   
  }
}
