import 'package:first/add_item/item_model.dart';
import 'package:first/favorite/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({required this.index , super.key});
   final int index ;
  @override
  Widget build(BuildContext context) {
    return Consumer <ItemModel>(
      builder: (context,item,child) {
        final currentItem =item.items[index];
        final fav = Provider.of<FavoriteModel>(context, listen: true);

        return IconButton(
            onPressed: () {
              fav.isFavorite(currentItem);
            },
            icon: Icon(Icons.favorite,
                color: item.items[index].favorite ? Colors.red : Colors.grey));
      }
    );
  }
}
