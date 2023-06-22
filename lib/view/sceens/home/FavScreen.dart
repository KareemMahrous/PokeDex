import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/constants/color_manager.dart';
import 'package:pokemon/view/components/widget/PokemonCard.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('fav').listenable(),
          builder: (context, box, child) {
            List<int> fav = [];
            for (int i = 0; i < box.length; i++) {
              if (box.get(i) != null) {
                fav.add(i);
              }
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: fav.length,
                    itemBuilder: (context, index) {

                      return PokemonCard(
                        pokemonName: box.get(fav[index]).toString(),
                        onPressed: () async {
                          await box.delete(fav[index]);
                          const snackBar = SnackBar(
                            content: Text("Removed from Favorite"),
                          );
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: redorangeColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}