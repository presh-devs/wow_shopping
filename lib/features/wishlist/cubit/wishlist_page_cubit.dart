import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'wishlist_page_state.dart';

class WishlistPageCubit extends Cubit<WishlistPageState> {
  WishlistPageCubit(this._repo) : super(const WishlistPageState()) {
    _repo.streamWishlistItems.listen(_onWishlistChanged);
  }

  final WishlistRepo _repo;

  selectItems(ProductItem item) {
    return state.selectedItems.contains(item.id);
  }

  void removeSelectedItems(Set<String> selectedItems) {
    for (final selected in selectedItems) {
      _repo.removeToWishlist(selected);
    }
    selectedItems.clear();
    emit(state.copyWith(
      selectedItems: {},
    ));
  }

  setSelected(ProductItem item, bool selected) {
    if (selected) {
      emit(state.copyWith(
          selectedItems: Set.from(state.selectedItems)..add(item.id)));
    } else {
      emit(state.copyWith(
          selectedItems: Set.from(state.selectedItems)..remove(item.id)));
    }
  }

  void toggleSelectAll() {
    final allIds = _repo.currentWishlistItems.map((el) => el.id).toList();
    if (state.selectedItems.containsAll(allIds)) {
      emit(state.copyWith(selectedItems: {}));
    } else {
      emit(state.copyWith(selectedItems: Set.from(state.selectedItems)..addAll(allIds)));
    }
  }

  void _onWishlistChanged(List<ProductItem> items) {
    emit(WishlistPageState(
      wishlistItems: items,
    ));
  }
}
