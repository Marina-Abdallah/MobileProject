import 'package:first/add_item/item.dart';
import 'package:first/add_item/item_model.dart';
import 'package:first/details/details_screen/details_page.dart';
import 'package:first/add_item/add_item_screen.dart';
import 'package:first/details/details_widget/details_widget.dart';
import 'package:first/favorite/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/profile_page/profile_page.dart';
import '../profile/user_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final imageProfile = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);
    final fav = Provider.of<FavoriteModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Icon(Icons.favorite, color: Colors.red),
          SizedBox(width: 5),
          Text(fav.fav.length.toString()),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon:
                imageProfile == null
                    ? Icon(Icons.account_box)
                    : CircleAvatar(
                      child: ClipOval(
                        child: Image.file(
                          imageProfile,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ),
        ],
      ),
      body:
          items.items.isEmpty?Center(child: Text("No Items",),):
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
        ),
        itemCount: items.items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              items.selectItem(
                Item(
                  images: items.items[index].images,
                  title: items.items[index].title,
                  body: items.items[index].body,
                  favorite: items.items[index].favorite,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage()),
              );
            },
            child: SizedBox(
              child: Column(
                children: [
                  Image.file(
                    items.items[index].images.first,
                    height: 125,
                    width: 125,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items.items[index].title),
                      FavoriteWidget(index: items.items.indexOf(items.items[index]),),
                      // IconButton(
                      //   onPressed: () {
                      //     Provider.of<FavoriteModel>(
                      //       context,
                      //       listen: false,
                      //     ).add(items.items[index]);
                      //   },
                      //   icon: Icon(Icons.favorite),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
