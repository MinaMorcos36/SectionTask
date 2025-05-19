import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sectiontask/profile/profile_page/profile_page.dart';
import 'package:provider/provider.dart';
import '../../add_item/add_item_screen.dart';
import '../../add_item/item_model.dart';
import '../../profile/user_model.dart';
import '../details_widget/favourite.dart';
import '../details_widget/season.dart'; // includes all widgets

class DetailsPage extends StatelessWidget {
  // final String? title;
  //final String? body;

  // final List<File>? image;

  const DetailsPage({
    // this.title, this.body, this.image,
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
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
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
          children: [
            // image == null || image!.isEmpty ? Image.asset("assets/tree.jpg") :
            Image.file(
              items.selectedItem!.images.first,
              height: 300,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavouriteWidget(index: items.items.indexOf(items.selectedItem!)),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                items.selectedItem!.body,
                // ?? "Default Body if Null",
              ),
            ),

            // image == null || image!.isEmpty
            //     ? Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         MySeason(url: "assets/spring.jpg", text: "Spring"),
            //         MySeason(url: "assets/fall.jpg", text: "Fall"),
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
        child: Icon(Icons.next_plan),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          );
        },
      ),
    );
  }
}
