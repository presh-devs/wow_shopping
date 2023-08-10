part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class InitialWishlistState extends WishlistState {}

final class WishlistPopulated extends WishlistState {
  WishlistPopulated(
    this.wishlistItems,
    
  );

  final List<ProductItem> wishlistItems;
  
}
var selectedItems = <String> {};

extension WishlistPopulatedExtension on WishlistPopulated {
  bool inWishlist(ProductItem item) {
    return wishlistItems.contains(item);
  }

  bool isSelected(ProductItem item) {
    print('${item.id} is contained = ${selectedItems.contains(item.id)}');
    return selectedItems.contains(item.id);
  }
}