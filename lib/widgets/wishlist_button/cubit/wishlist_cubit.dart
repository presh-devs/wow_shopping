import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/backend/wishlist_repo.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._repo) : super(InitialWishlistState()) {
    _repo.streamWishlistItems.listen(_onWishlistChanged);
    emit(WishlistPopulated(
      _repo.currentWishlistItems,
    ));
  }

  final WishlistRepo _repo;
  void _onWishlistChanged(List<ProductItem> items) {
    emit(WishlistPopulated(
      items,
    ));
  }

  void addItem(ProductItem item) {
    _repo.addToWishlist(item.id);
  }

  void removeItem(ProductItem item) {
    _repo.removeToWishlist(item.id);
  }

  // bool selectItems(ProductItem item) {

  //   return !selectedItems.contains(item.id)
  //       ? selectedItems.remove(item.id)
  //       : selectedItems.add(item.id);
  // }

  // void removeSelectedItems(Set<String> selectedItems) {
  //   for (final selected in selectedItems) {
  //     _repo.removeToWishlist(selected);
  //   }
  //   selectedItems.clear();

  // }

  // setSelected(ProductItem item, bool selected) {

  //   if (selected) {
  //     selectedItems.add(item.id);

  //   } else {
  //     selectedItems.remove(item.id);
  //   }
  //   emit(WishlistPopulated(_repo.currentWishlistItems, ));
  // }

  // void toggleSelectAll(Set<String>? selectedItems) {
  //   final allIds = _repo.currentWishlistItems.map((el) => el.id).toList();
  //   print(allIds);
  //   print(selectedItems);
  //   //if(selectedItems!.isEmpty) return;
  //   if (selectedItems!.containsAll(allIds)) {
  //     print('clear');
  //     selectedItems.clear();
  //   } else {
  //     print('add');
  //     selectedItems.addAll(allIds);
  //     print(selectedItems);
  //   }
  // }
}
