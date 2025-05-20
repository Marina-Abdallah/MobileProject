import 'package:first/add_item/add_item_screen.dart';
import 'package:first/add_item/item_model.dart';
import 'package:first/profile/profile_page/profile_page.dart';
import 'package:first/profile/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../details_widget/favorite.dart';
import '../details_widget/season.dart';

class DetailsPage extends StatelessWidget {
  // final String? title;
  // final String? body;
  // final List<File>? image;
  const DetailsPage({
    //this.title, this.body, this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon:
                profileImage == null
                    ? Icon(Icons.account_box)
                    : CircleAvatar(
                      child: ClipOval(
                        child: Image.file(
                          profileImage,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ),
        ],
        centerTitle: true,
        title: Text("The ${items.selectedItem!.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //image == null || image!.isEmpty
            //     ? Image.asset("assets/Tree.jpeg"):
            Image.file(
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              items.selectedItem!.images.first,
            ),
            Row(
              children: [
                 FavoriteWidget(index: items.items.indexOf(items.selectedItem!)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                items.selectedItem!.body,
                //?? "My details page",
              ),
            ),
            // image == null || image!.isEmpty
            //     ? Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         MySeason(url: "assets/Fall.jpg", text: "Fall"),
            //         MySeason(url: "assets/Spring.jpg", text: "Spring"),
            //       ],
            //     )
            //     :
            SizedBox(
              height: 500,
              child: GridView.builder(
                itemCount: items.selectedItem!.images.length,
                itemBuilder:
                    (context, index) => Image.file(
                      items.selectedItem!.images[index],
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
