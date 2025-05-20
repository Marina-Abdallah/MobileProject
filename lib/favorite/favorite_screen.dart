import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite")),
      body: Consumer<FavoriteModel>(
        builder: (context, fav, child) {
          if (fav.fav.isEmpty) {
            return const Center(
              child: Text("No items", style: TextStyle(fontSize: 18)),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
              ),
              itemCount: fav.fav.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Column(
                    children: [
                      Image.file(
                        fav.fav[index].images.first,
                        height: 125,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(fav.fav[index].title),
                          IconButton(
                            onPressed: (){

                            fav.fav[index].favorite=false;
                            fav.remove(fav.fav[index]);
                            },
                            icon: const Icon(Icons.favorite, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
