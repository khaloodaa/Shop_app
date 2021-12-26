
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void UserLogin({
  required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  bool ispassword=true;
  IconData suffix=Icons.visibility_outlined;

  void ChangePasswordVisibility(){
    ispassword= !ispassword;
    suffix= ispassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}