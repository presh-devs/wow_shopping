import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_shopping/models/product_item.dart';

import '../../../backend/product_repo.dart';

final topSellingProvider = FutureProvider<List<ProductItem>>((ref) {
  return ref.read(productsRepoProvider).fetchTopSelling();
});
