import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/getfavorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/compoments/compoments.dart';
import 'package:shop_app/shared/compoments/constants.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int Currentindex = 0;

  List<BottomNavigationBarItem> NavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];
  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottomNav(int index) {
    Currentindex = index;
    if (Currentindex == 3) GetProfileData();
    if (Currentindex == 2) GetFavoritesData();
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void GetHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      //njibo data wnhatoha f object home model
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((e) {
        favorites.addAll({
          e.id: e.inFavorites!,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void GetCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      //njibo data wnhatoha f object home model
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  FavoritesModel? favoritesModel;

  void SaveFavorites(int ProductID) {
    favorites[ProductID] = !favorites[ProductID]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': ProductID,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      if (!favoritesModel!.status!)
        favorites[ProductID] = !favorites[ProductID]!;
      else
        GetFavoritesData();

      emit(ShopChangeSuccessFavoritesState(favoritesModel!));
    }).catchError((error) {
      emit(ShopChangeErrorFavoritesState());
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void GetFavoritesData() {
    emit(ShopLoadingFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      //njibo data wnhatoha f object home model
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? shopLoginModel;

  void GetProfileData() {
    emit(ShopLoadingProfileState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      //njibo data wnhatoha f object home model
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessProfileState(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileState());
    });
  }


  void UpdateProfil({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        },
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(shopLoginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
