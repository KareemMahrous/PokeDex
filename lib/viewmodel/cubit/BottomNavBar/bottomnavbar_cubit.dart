import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../view/sceens/home/FavScreen.dart';
import '../../../view/sceens/home/HomeScreen.dart';

part 'bottomnavbar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  int currentPage =0 ;
  List <Widget> pages = [HomeScreen(),FavScreen()];
  BottomNavBarCubit() : super(BottomNavBarInitial());
  static BottomNavBarCubit get(context)=>BlocProvider.of(context);
  void changeindex(newindex){
    currentPage=newindex;
    emit(IndexChanged());
  }
}
