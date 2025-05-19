import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sectiontask/profile/user_model.dart';
import '../profile_widget/options.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile ")),
      body: Column(
        children: [
          Center(
            child: Consumer <UserModel>(
              builder: (context, userModel, child) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      child:
                      userModel.user?.image == null
                          ? Icon(Icons.person, size: 200)
                          : ClipOval(
                        child: Image.file(
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          userModel.user!.image!,
                        ),
                      ),
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
                                  Text(
                                    "Profile",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Options(
                                        onPressed: () {
                                          userModel.imageSelector(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        title: 'Camera',
                                        icon: Icons.camera_alt,
                                      ),
                                      Options(
                                        onPressed: () {
                                          userModel.imageSelector(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        title: 'Gallery',
                                        icon: Icons.image,
                                      ),
                                      if (userModel.user?.image != null)
                                        Options(
                                          selectedImage: userModel.user?.image,
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
                        iconSize: 40,
                      ),
                    ),
                  ],
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}

