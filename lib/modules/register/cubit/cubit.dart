
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(RegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModel loginModel;
  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool ispassword=true;
  IconData suffix=Icons.visibility_outlined;

  void ChangePasswordVisibility(){
    ispassword= !ispassword;
    suffix= ispassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}