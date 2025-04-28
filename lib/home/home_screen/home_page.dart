import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sectiontask/profile/profile_page/profile_page.dart';

import '../../first_screen.dart';
import '../home_widget/home_widget.dart'; // includes all widgets

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;

  final List<File>? image;

  const MyHomePage({this.title, this.body, super.key, this.image});

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.account_box),
          ),
        ],
        centerTitle: true,
        title: Text("The ${title ?? "Tree"}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            image == null || image!.isEmpty ? Image.asset("assets/tree.jpg"): Image.file(image![0], height: 300, fit: BoxFit.cover, width: double.infinity,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavouriteWidget(),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                body ?? "Default Body if Null",
              ),
            ),

            image == null || image!.isEmpty
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MySeason(url: "assets/spring.jpg", text: "Spring"),
                    MySeason(url: "assets/fall.jpg", text: "Fall"),
                  ],
                )
                : SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: image!.length,
                    itemBuilder:
                        (context, index) => Image.file(
                          image![index],
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
            MaterialPageRoute(builder: (context) => FirstScreen()),
          );
        },
      ),
    );
  }
}
