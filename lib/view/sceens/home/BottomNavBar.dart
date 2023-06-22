import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pokemon/constants/color_manager.dart';
import 'package:pokemon/viewmodel/cubit/BottomNavBar/bottomnavbar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
          BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
          return Scaffold(
            body: myCubit.pages[myCubit.currentPage],
            bottomNavigationBar: GNav(
              backgroundColor: bottomNavBar,
              rippleColor: bottomNavBar,
              hoverColor: background,

              gap: 2,
              activeColor:borderColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 80.w,vertical: 20.h),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: bottomNavBar,
              color: greyText2Color,
              tabs: const [
                GButton(
                    icon: Icons.home
                ),
                GButton(
                  icon: Icons.favorite,
                ),
              ],
              onTabChange: (index) {
                myCubit.changeindex(index);
              },
            ),
          );
        },
      ),
    );
  }
}