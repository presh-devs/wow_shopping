part of 'wishlist_page_cubit.dart';

final class WishlistPageState {
  final List<ProductItem> wishlistItems;
  final Set<String> selectedItems;

  const WishlistPageState(
      {this.wishlistItems = const <ProductItem>[],
      this.selectedItems = const <String>{}});

  WishlistPageState copyWith({
    List<ProductItem>? wishlistItems,
    Set<String>? selectedItems,
  }) {
    return WishlistPageState(
      wishlistItems: wishlistItems ?? this.wishlistItems,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
