import 'package:first/details/details_widget/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/profile_page/profile_page.dart';
import '../profile/user_model.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreen();
}

class _AboutUsScreen extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
    final imageProfile = user?.image;

    List<Map<String, String>> items = [
      {"image": "assets/Fall.jpg", "text": "Autumn Vibes"},
      {"image": "assets/Spring.jpg", "text": "Spring Colors"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: imageProfile == null
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListTile with name and email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Our Seasons Gallery", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        SizedBox( height: 250,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount:items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [

                    MySeason(url:   items[index]["image"]! , text:  items[index]["text"]!)
                    // Positioned.fill(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8),
                    //     child: Image.asset(
                    //       items[index]["image"]!,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 8,
                    //   left: 8,
                    //   right: 8,
                    //   child: Container(
                    //     color: Colors.black54,
                    //     padding: const EdgeInsets.all(2),
                    //     child: Text(
                    //       items[index]["text"]!,
                    //       style: const TextStyle(color: Colors.white),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.abc),
            title: Text("name"),
            subtitle: TextField(),
          ),
          ListTile(
            leading: Icon(Icons.abc),
            title: Text("email"),
            subtitle: TextField(),
          ),
        ],
      ),
    );
  }
}