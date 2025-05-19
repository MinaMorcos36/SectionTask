import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_item/add_item_screen.dart';
import '../add_item/item_model.dart';
import '../profile/profile_page/profile_page.dart';
import '../profile/user_model.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final profileImage = Provider.of<UserModel>(context).user?.image;
    final items = Provider.of<ItemModel>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text("About Us"),
        actions: [
          IconButton(onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }, icon:
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
      ),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
        ),
        itemCount: items.items.length,

        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                Image.file(
                  items.items[index].images.first,
                  height: 125,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(items.items[index].title),
                  ],
                ),
              ],
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
