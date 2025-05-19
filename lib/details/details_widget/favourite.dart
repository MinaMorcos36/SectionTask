import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sectiontask/favorite/favorite_model.dart';

import '../../add_item/item_model.dart';

class FavouriteWidget extends StatelessWidget {
  const FavouriteWidget({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(
      builder: (context, item, child) {
        final fav = Provider.of<FavoriteModel>(context, listen: true,);
        final currentItem = item.items[index];
        return IconButton(
          onPressed: () {
            fav.isFavorite(currentItem);
          },
          icon: Icon(
            Icons.favorite,
            color: item.items[index].favourite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
