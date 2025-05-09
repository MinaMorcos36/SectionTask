import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker imagePicker = ImagePicker();

  File? selectedImage;

  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null && mounted) {
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile ")),
      body: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 100,
                  child:
                      selectedImage == null
                          ? Icon(Icons.person, size: 200)
                          : ClipOval(
                            child: Image.file(
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                              selectedImage!,
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
                                          imageSelector(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                        title: 'Camera',
                                        icon: Icons.camera_alt,
                                      ),
                                      Options(
                                        onPressed: () {
                                          imageSelector(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        title: 'Gallery',
                                        icon: Icons.image,
                                      ),
                                      if (selectedImage != null)
                                        Options(
                                          selectedImage: selectedImage,
                                          onPressed: () {
                                            if (mounted) {
                                              setState(() {
                                                selectedImage = null;
                                              });
                                            }
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
            ),
          ),
        ],
      ),
    );
  }
}

class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  Colors? color;

  File? selectedImage;

  final VoidCallback onPressed;

  Options({
    this.selectedImage,
    this.color,
    required this.onPressed,
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: selectedImage == null ? Colors.black : Colors.red,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        Text(title),
      ],
    );
  }
}
