import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/viewmodel/database/network/dio_helper.dart';
import 'package:pokemon/viewmodel/database/network/end_points.dart';

import '../../../model/AllPokemonModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  AllPokemonModel? allPokemonModel;
  bool heartPressed = false;


  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);


  Future getallData() async {
    emit(HomeLoading());
    try{
    DioHelper.getData(url: allPokemonEndPoint).then((value) {
      print("Full data" "${value.data}");
      allPokemonModel = AllPokemonModel.fromJson(value.data);
      print(
          "The result of the json is ${allPokemonModel!.results![2].name.toString()}");
      emit(HomeSuccess(allPokemonModel!));
    });}catch(e){
      emit(HomeFailed());
    }
  }
}
