import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/constants/color_manager.dart';
import 'package:pokemon/view/components/widget/PokemonCard.dart';

import '../../../viewmodel/cubit/Home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getallData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit myCubit = HomeCubit.get(context);
          return ValueListenableBuilder(
            valueListenable: Hive.box("fav").listenable(),


            builder: (context, box, child) => Scaffold(
              backgroundColor: background,

              body: myCubit.allPokemonModel?.results == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: borderColor,
                      ),
                    )
                  : Center(
                      child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                          child: Column(children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: myCubit
                                        .allPokemonModel!.results!.length,
                                    itemBuilder: (context, index) {

                                      final isFav = box.get(index) != null;
                                      return PokemonCard(
                                        onPressed: () async {
                                          if (isFav) {
                                            await box.delete(index);
                                          } else {
                                            await box.put(
                                                index,
                                                myCubit.allPokemonModel!
                                                    .results![index].name
                                                    .toString());
                                          }
                                           print(box.values);

                                          final snackBar = SnackBar(
                                              content: !isFav
                                                  ? const Text(
                                                      "Added to Favorite")
                                                  : const Text(
                                                      "Remove from Favorite"));
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                        },
                                        pokemonName: myCubit.allPokemonModel!
                                            .results![index].name
                                            .toString(),
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: redorangeColor,
                                        ),
                                      );
                                    }))
                          ]))),
            ),
          );
        },
      ),
    );
  }
}
