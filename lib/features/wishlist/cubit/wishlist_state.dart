part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistPopulated extends WishlistState {
  WishlistPopulated(
    this.wishlistItems,
    this.selectedItems,
  );

  final List<ProductItem> wishlistItems;
  final Set<String>? selectedItems;
}


extension WishlistPopulatedExtension on WishlistPopulated {
  bool inWishlist(ProductItem item) {
    return wishlistItems.contains(item);
  }
}