
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding=CacheHelper.getData(key: 'onboarding');
  // token decrito f constants bch yban nhtago fl cubit
  token=CacheHelper.getData(key: 'token');


  // ignore: unnecessary_null_comparison
  if(onBoarding != null){
    // ignore: unnecessary_null_comparison
    if(token != null){
      widget=ShopLayout();
    }else{
      widget=ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }


  runApp(MyApp(
    StartWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget StartWidget;

  MyApp({required this.StartWidget});


  @override
  Widget build(BuildContext context) {
          return BlocProvider(
            create: (BuildContext context)=>ShopCubit()..GetHomeData()..GetCategoriesData(),
            child: BlocConsumer<ShopCubit,ShopStates>(
              listener: (context,state){},
              builder: (context,state){
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lighttheme,
                  home: Directionality(
                    textDirection: TextDirection.ltr,
                    child: StartWidget,
                  ),
                );
              },
            ),
          );
  }
}