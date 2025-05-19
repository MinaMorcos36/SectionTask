import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sectiontask/favorite/favorite_model.dart';
import 'package:sectiontask/profile/profile_page/profile_page.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoriteModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        actions: [
          SizedBox(width: 5, height: 5),
          Text(fav.fav.length.toString()),
          IconButton(
            onPressed: () {
              MaterialPageRoute(builder: (context) => ProfilePage());
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),

      body: Consumer<FavoriteModel>(
        builder:
            (context, fav, child) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
              ),
              itemCount: fav.fav.length,

              itemBuilder: (context, index) {
                return SizedBox(
                  child: Column(
                    children: [
                      Image.file(
                        fav.fav[index].images.first,
                        height: 125,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(fav.fav[index].title),
                          IconButton(
                            onPressed: () {
                              fav.fav[index].favourite = false;
                              fav.remove(fav.fav[index]);
                            },
                            icon: Icon(Icons.favorite, color: Colors.red,),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
