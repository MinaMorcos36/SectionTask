import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sectiontask/add_item/item.dart';
import 'package:sectiontask/add_item/item_model.dart';

import '../dashboard/dashboard_screen.dart';
import '../details/details_screen/details_page.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController title = TextEditingController();

  TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(backgroundColor: Colors.transparent),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ocean.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ItemModel>(
          builder:
              (context, itemModel, child) => ListView(
                children: [
                  SizedBox(height: 30),

                  itemModel.selectedImage!.isEmpty
                      ? Container(
                        color: Colors.white38,
                        height: 150,
                        width: MediaQuery.sizeOf(context).width - 20,
                        child: IconButton(
                          onPressed: () {
                            itemModel.imageSelector();
                          },
                          icon: Icon(Icons.camera_alt),
                        ),
                      )
                      : Row(
                        children: [
                          Container(
                            color: Colors.white38,
                            height: 100,
                            width: 100,
                            child: IconButton(
                              onPressed: () {
                                itemModel.imageSelector();
                              },
                              icon: Icon(Icons.camera_alt),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.sizeOf(context).width - 120,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children:
                                  itemModel.selectedImage!
                                      .map(
                                        (toElement) => Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                child: Image.file(
                                                  toElement,
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                itemModel.removeImage(
                                                  itemModel.selectedImage!
                                                      .indexOf(toElement),
                                                );
                                              },
                                              icon: Icon(Icons.cancel),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: title, //34an nsave el data

                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: body,

                      //34an nsave el data
                      minLines: 3,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Body",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final item = Provider.of<ItemModel>(context, listen: false);

          item.addItem(
            Item(
              images: List.from(item.selectedImage!),
              title: title.text,
              body: body.text,
              favourite: false,
            ),
          );

          item.selectedImage!.clear();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );

          // Navigator.pushReplacement(
          // context,
          // MaterialPageRoute(
          // builder:
          // (context) => DetailsPage(
          // title: title.text,
          //  body: body.text,
          //    image: selectedImage,
          //    ),
          //),
          //);
        },
      ),
    );
  }
}
