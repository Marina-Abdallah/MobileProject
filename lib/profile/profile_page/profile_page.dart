import 'dart:io';
import 'package:first/Registration_Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme_provider.dart';
import '../profile_widget/options.dart';
import '../user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? '';
    final email = prefs.getString('userEmail') ?? '';

    setState(() {
      _nameController.text = name;
      _emailController.text = email;
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Provider.of<UserModel>(context, listen: false).setUserName('');
    //Provider.of<UserModel>(context, listen: false).clearUser();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SplashScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserModel>(
          builder: (context, userModel, _) {
            return Text(" ${userModel.user?.name ?? 'Profile'}");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Consumer<UserModel>(
              builder: (context, userModel, child) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          userModel.user?.image != null
                              ? FileImage(userModel.user!.image!)
                              : null,
                      child:
                          userModel.user?.image == null
                              ? Icon(Icons.person, size: 100)
                              : null,
                    ),
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => SizedBox(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Profile",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Options(
                                            onPressed: () {
                                              userModel.imageSelector(
                                                ImageSource.camera,
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: 'Camera',
                                            icon: Icons.camera_alt,
                                          ),
                                          Options(
                                            onPressed: () {
                                              userModel.imageSelector(
                                                ImageSource.gallery,
                                              );
                                              Navigator.pop(context);
                                            },
                                            title: 'Gallery',
                                            icon: Icons.image,
                                          ),
                                          if (userModel.user?.image != null)
                                            Options(
                                              onPressed: () {
                                                userModel.removeImage();
                                                Navigator.pop(context);
                                              },
                                              title: 'Delete Photo',
                                              icon: Icons.delete,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                        icon: Icon(Icons.camera_alt),
                        iconSize: 30,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: themeProvider.isDarkMode,
            onChanged: (val) {
              themeProvider.toggleTheme();
            },
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Name"),
            subtitle: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Enter your email"),
            ),
          ),
        ],
      ),
    );
  }
}
